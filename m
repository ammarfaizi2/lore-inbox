Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbTEEN1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 09:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbTEEN1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 09:27:42 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:46828 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP id S262189AbTEEN1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 09:27:40 -0400
Date: Mon, 5 May 2003 20:30:38 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: Arjan van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
Message-ID: <Pine.SGI.4.10.10305051745290.8200163-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, May 05, 2003 at 04:01:25PM +0700, Dmitry A. Fedorov wrote:
>> But why module should not have ability to call any function which is
>> available from user space?

>> Almost all of my third-party drivers are broken by this.
>> What is worse, redhat "backported" this "feature" to their 2.4
>> patched kernels and now I should distinguish 2.4 and "redhat 2.4"
>> in my compatibility headers.

From: Arjan van de Ven <arjanv@redhat.com>
> that's you you can just call sys_read() and co directly.

Yes, for redhat kernels - almost all of sys_* functions are exported.
And there is kernel.org's one with only few sys_* exported.
And how I will distinguish redhat's kernel from other ones? - there is
no something like #define REDHAT_PATCHED in headers.
I don't want to have separate driver source version
for each of incompatible kernel variant, I prefer to have single
driver source which is adapted to user's environment at compilation
time.

From: Christoph Hellwig <hch@infradead.org>
> What about just fixing your drivers instead of moaning?  If you
> submit a pointer to your driver source and explain what you want to
> do someone might even help you..

Of course, I will fix my drivers (permanent kernel changes
provides us maintainence job forever :).

For example:

http://www.rtdusa.com/software/RTDFinland/ECAN_Linux.zip
http://www.rtdusa.com/software/RTDFinland/UPS25_Linux.ZIP

I use the following calls:

sys_mknod
sys_chown
sys_umask
sys_unlink

for creating/deleting /dev entries dynamically on driver
loading/unloading. It allows me to acquire dynamic major
number without devfs and external utility of any kind.
And there is no risk of intersection with statically assigned major
numbers, as it is for many others third-party sources.

It works long time for any kernels from 2.0 to 2.4 (except the last
redhat's 2.4) and it should works with 2.6, I hope.


I use sys_write to output loading/device detection/diagnostic
messages to process's stderr when appropriate. Yes, it may look as
"wrong thing" but it uses only legal kernel mechanisms and it saves
lots of time with e-mail support:
/sbin/insmod driver verbose=1 2>&1 | mail -s 'it does not works' me@


It would be nice if either sys_call_table left exported and placed in
read-only data section to prevent modification (do you want just that?)
or _all_ of sys_* function would be exported in original kernel.

