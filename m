Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTKMBWz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 20:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTKMBWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 20:22:55 -0500
Received: from zok.sgi.com ([204.94.215.101]:19857 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261850AbTKMBWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 20:22:53 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 hangs upon echo > /proc/acpi/alarm 
In-reply-to: Your message of "Wed, 12 Nov 2003 20:33:18 +0800."
             <200311122033.18729.mhf@linuxmail.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Nov 2003 12:21:02 +1100
Message-ID: <2758.1068686462@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Nov 2003 20:33:18 +0800, 
Michael Frank <mhf@linuxmail.org> wrote:
>ACPI version is 20031002
>
>Initial backtrace obtained with kdb:
>
>acpi_os_read_port+36
>acpi_hw_lowlevel_read+7b
>acpi_ev_gpe_detect+94
>acpi_ev_sci_xrupt_handler+3c
>acpi_irq+d
>handle_IRQ_event+31
>do_IRQ+72
>call_do_IRQ+5
>do_softirq+5a
>do_IRQ+a1
>proc_file_write+9b
>sys_write+be
>system_call+33
>
>Further stepping shows endless loop around:
>
>acpi_ev_gpe_detect+80
>  acpi_hw_lowlevel_read
>    acpi_os_read_port
>    acpi_ut_get_region_name
>    acpi_ut_debug_print 
>  acpi_ut_debug_print
>  jmp acpi_ev_gpe_detect+80
>
>Debugging is compiled in, but no meesages go to dmesg
>
>How to enable acpi_ut_debug_print output?

printk() can be called from anywhere but the text is only stored in the
log buffer.  The text is written from the log buffer to the console or
syslog when the kernel is not running in interrupt context.  This is a
common problem with printk, you get no output when debugging interrupt
problems.

Since you have already applied the kdb patch, change acpi to add
#include <linux/kdb.h> and call kdb_printf() instead of printk for
debugging messages.  kdb_printf uses polling mode I/O so you get the
output immediately.

