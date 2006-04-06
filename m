Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWDFLkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWDFLkh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 07:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWDFLkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 07:40:37 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:16798 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751136AbWDFLkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 07:40:36 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH] Add a /proc/self/exedir link
To: Neil Brown <neilb@suse.de>, Mike Hearn <mike@plan99.net>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Reply-To: 7eggert@gmx.de
Date: Thu, 06 Apr 2006 13:39:49 +0200
References: <5XGlt-GY-23@gated-at.bofh.it> <5XGOz-1eP-35@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FRSqP-0000g3-9i@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:
> On Tuesday April 4, mike@plan99.net wrote:

>> To clarify, I'm proposing this patch for eventual mainline inclusion.
>> 
>> It adds a simple bit of API - a symlink in /proc/pid - which makes it
>> easy to build relocatable software:
>> 
>>    ./configure --prefix=/proc/self/exedir/..

[...]

> It strikes me that this is very fragile.  If the application calls
> anything out of /bin or /usr/bin etc passing a path name which works
> for the application, it will break for the helper.

ACK.

> It also requires all binaries use by the application to live in the
> same directory.  This would be OK  for some applications, but not for
> everything.
> 
> It sounds to me like you want a private, inherited, name space, and
> Linux provides those via CLONE_NEWNS, however you probably need root
> access to make that work, which isn't ideal.

This isn't going to rock either. If process A links
$PID->namespace:/const/exedir/ to /mnt/net/host_a/foo/bin and passes
/const/exedir/../lib/foo to process B, this process B must not
link it's $PID->namespace:/const/exedir/ to e.g. /opt/B/bin, but
exactly this is going to happen if you use a constant string.

> I think you'd have move luck (ab)using an environment variable.
> Make
>    /proc/self/env_prefix
> be a symlink pointing to whatever the "PREFIX" environment variable
> stores.

Same problem.


IMO the program must be aware of the get-my-exedir feature, just configuring
--prefix=/proc/... is aiming for your feet.

/proc/pid/exedir may be a way to access the program files after changing the
namespace, but it may also be a security risk leaving the original namespace
accessible. Therefore I suggest abandoning the exedir idea and instead

1) change the programs to be aware of it's exedir:
   (my $exedir=`cat /proc/self/exe`) =~ s,/[^/]+$,,);
   if ($libdir !~ m,^/,) { $libdir = $exedir.'/'.$libdir };
 - or -
   ln -s /mnt/net/host_a/foo /usr/local/foo
   (cd /usr/local/bin && for a in ../foo/bin; do ln -s "$a";done)
2) If you want access across namespaces, use fopen etc. on an open
   directory handle
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
