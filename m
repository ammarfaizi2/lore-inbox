Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbWFCLTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWFCLTh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 07:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbWFCLTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 07:19:37 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:62900 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932607AbWFCLTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 07:19:36 -0400
Date: Sat, 3 Jun 2006 07:19:34 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: linux-kernel@vger.kernel.org, ltt-dev@shafik.org
Subject: Interrupts disabled for too long in printk
Message-ID: <20060603111934.GA14581@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.31-grsec (i686)
X-Uptime: 07:05:56 up 28 days, 14:14,  3 users,  load average: 2.44, 1.81, 1.40
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I ran some experiments with my kernel tracer (LTTng : http://ltt.polymtl.ca)
that showed missing interrupts. I wrote a small paper to show how to use my
tracer to solve this kind of problem which I presented at the CE Linux Form
last April.

http://tree.celinuxforum.org/CelfPubWiki/ELC2006Presentations?action=AttachFile&do=get&target=celf2006-desnoyers.pdf

It shows that, when the serial console is activated, the following code disables
interrupts for up to 15ms. On a system configured with a 250HZ timer (each 4ms),
it means that 3 scheduler ticks are lost.

In the current git :

kernel/printk.c: release_console_sem()

        for ( ; ; ) {
----->          spin_lock_irqsave(&logbuf_lock, flags);
                wake_klogd |= log_start - log_end;
                if (con_start == log_end)
                        break;                  /* Nothing to print */
                _con_start = con_start;
                _log_end = log_end;
                con_start = log_end;            /* Flush */
                spin_unlock(&logbuf_lock);
                call_console_drivers(_con_start, _log_end);
----->          local_irq_restore(flags);
        }

I guess interrupts are disabled for a good reason (to protect this spinlock for
being taken by a nested interrupt handler. One way I am thinking to fix this
problem would be to do a spin try lock and fail if it is already taken.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
