Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVBRDWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVBRDWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 22:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVBRDWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 22:22:55 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:20355 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261261AbVBRDWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 22:22:52 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [PATCH] add umask parameter to procfs
To: Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
       viro@parcelfarce.linux.theplanet.co.uk
Reply-To: 7eggert@gmx.de
Date: Fri, 18 Feb 2005 04:22:49 +0100
References: <fa.h7bdq0l.im6ej1@ifi.uio.no> <fa.fep4kfp.gmci2d@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1D1yjD-00035Y-5u@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> wrote:
> On Thu, Feb 17, 2005 at 03:41:19PM -0800, Andrew Morton wrote:
>> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:

>> > Add proc.umask kernel parameter.  It can be used to restrict permissions
>> > on the numerical directories in the root of a proc filesystem, i.e. the
>> > directories containing process specific information.
>> > 
>> > E.g. add proc.umask=077 to your kernel command line and all users except
>> > root can only see their own process details (like command line
>> > parameters) with ps or top.  It can be useful to add a bit of privacy to
>> > multi-user servers.

>> The feature seems fairly obscure, although very simple.
>> Is anyone actually likely to use this?

I'm using a openwall-patched kernel on some of my boxes with a similar
feature. I did not yet test this patch, but I like it. It's cheap, and
it fixes a potential security leak.

> what about parents (and especially the init process)
> some tools like pstree (or ps in certain cases) depend
> on their visibility/accessability ...

pstree will break if /proc/1 isn't readable, unless you specify a readable
starting pid. Since this is not the default case, this is IMO ok. (It should
be easy to rewrite it to trace the ppid-chains like "ps auxf" already does
correctly, or rather implement it in ps where it belongs).

None of my other tools seemed to stop working in an unintended way, but I
don't usurally spend my time watching processes.

Sample output of "ps auxf" on a openwall-patched system:
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
7eggert  22504  5.0  3.5  2800 1608 pts/4    S    04:14   0:00 -bash
7eggert  22522  0.0  1.7  2856  792 pts/4    R    04:14   0:00  \_ ps auxf
7eggert  22483  2.3  3.4  2800 1588 pts/2    S    04:14   0:00 -bash

> what if you want to change it afterwards (when tools
> did break)?

Change the kernel command line back and reboot (or reload the module).

