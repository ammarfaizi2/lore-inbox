Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263446AbSITUff>; Fri, 20 Sep 2002 16:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263460AbSITUff>; Fri, 20 Sep 2002 16:35:35 -0400
Received: from pr-66-150-46-254.wgate.com ([66.150.46.254]:16844 "EHLO
	mail.tvol.net") by vger.kernel.org with ESMTP id <S263446AbSITUfe>;
	Fri, 20 Sep 2002 16:35:34 -0400
Message-ID: <3D8B87C7.7040106@wgate.com>
Date: Fri, 20 Sep 2002 16:40:39 -0400
From: Michael Sinz <msinz@wgate.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.1b) Gecko/20020813
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mks@sinz.org
CC: marcelo@conectiva.com.br, Robert Love <rml@tech9.net>, msinz@wgate.com,
       Linux Kernel List <linux-kernel@vger.kernel.org>, akpm@digeo.com,
       riel@conectiva.com.br, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] kernel 2.4.19 & 2.5.38 - coredump sysctl
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

coredump name format control via sysctl

Provides for a way to securely move where core files show up and to
set the name pattern for core files to include the UID, Program,
Hostname, and/or PID of the process that caused the core dump.
This is very handy for diskless clusters where all of the core
dumps go to the same disk and for production servers where core
dumps want to be segregated from the main production disks.

I have again updated the patch to work with 2.4.19 and 2.5.36
kernels and am now hosting it on my web site at:

	http://www.sinz.org/Michael.Sinz/Linux/

-- Patch background and how it works --

What I did with this patch is provide a new sysctl that lets you
control the name of the core file. The this name is actually a format
string such that certain values from the process can be included.
If the sysctl is not used to change the format string, the behavior
is exactly the same as the current kernel coredump behavior.

The default name format is set to "core" to match the current
behavior of the kernel. Old behavior of appending the PID to
the "core" name is also preserved with added logic of only doing
so if the PID is not already part of the name format.  This fully
preserves current behaviors within the system while still providing
for the full control of the format of the core file name.  Thus
current behavior is not a special case but "falls out" of the
general code when the format is set to "core".

The following format options are available in that string:

       %P   The Process ID (current->pid)
       %U   The UID of the process (current->uid)
       %N   The command name of the process (current->comm)
       %H   The nodename of the system (system_utsname.nodename)
       %%   A "%"

For example, in my clusters, I have an NFS R/W mount at /coredumps
that all nodes have access to. The format string I use is:

	sysctl -w "kernel.core_name_format=/coredumps/%H-%N-%P.core"

This then causes core dumps to be of the format:

	/coredumps/whale.sinz.org-badprogram-13917.core

I used upper case characters to reduce the chance of getting confused
with format() characters and to be somewhat simular to the mechanism
that exists on FreeBSD.


