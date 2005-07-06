Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVGFFCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVGFFCU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVGFE7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 00:59:53 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27894 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262136AbVGFCw2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:52:28 -0400
Message-ID: <42CB4717.4050609@mvista.com>
Date: Tue, 05 Jul 2005 19:51:03 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Build TAGS problem with O=
References: <42C5B967.6040908@mvista.com>
In-Reply-To: <42C5B967.6040908@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> If you try:
> make O=/usr/src/ver/2.6.13-rc/obj/ -j5 LOCALVERSION=_2.6.13-rc TAGS 
> ARCH=i386
> 
> it fails with:
>   MAKE   TAGS
> find: security/selinux/include: No such file or directory
> find: include: No such file or directory
> find: include/asm-i386: No such file or directory
> find: include/asm-generic: No such file or directory
> 
> 
> The problem seems to be this bit of the topdir Makefile:
> 
> 
> #We want __srctree to totally vanish out when KBUILD_OUTPUT is not set
> #(which is the most common case IMHO) to avoid unneeded clutter in the 
> big tags file.
> #Adding $(srctree) adds about 20M on i386 to the size of the output file!
> 
> ifeq ($(KBUILD_OUTPUT),)
> __srctree =
> else
> __srctree = $(srctree)/
> endif
> 
> It would appear that the "ifeq ($(KBUILD_OUTPUT),)" is doing the wrong 
> thing.  I am not a make expert, but I have had a lot of BAD experience 
> trying to use this construct.  Any one up to proposing a fix?
> 
The problem appears to be that KBUILD_OUTPUT is NOT defined after make reruns 
itself.  Here is a fix:

Signed-off-by:  George Anzinger  <george@mvista.com>

--- /usr/src/linux-2.6.12-org/Makefile	2005-07-01 14:37:44.000000000 -0700
+++ /usr/src/linux-2.6.13-rc/Makefile	2005-07-05 19:45:00.588314304 -0700
@@ -1149,7 +1149,7 @@
  #(which is the most common case IMHO) to avoid unneeded clutter in the big 
tags file.
  #Adding $(srctree) adds about 20M on i386 to the size of the output file!

-ifeq ($(KBUILD_OUTPUT),)
+ifeq ($(src),$(obj))
  __srctree =
  else
  __srctree = $(srctree)/



-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
