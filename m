Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945946AbWGOXSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945946AbWGOXSj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 19:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945959AbWGOXSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 19:18:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41863 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1945946AbWGOXSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 19:18:38 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Tilman Schmidt <tilman@imap.cc>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm2: process `showconsole' used the removed sysctl system call
References: <44B8FE64.6040700@imap.cc> <20060715154200.e9138a6b.akpm@osdl.org>
Date: Sat, 15 Jul 2006 17:17:47 -0600
In-Reply-To: <20060715154200.e9138a6b.akpm@osdl.org> (Andrew Morton's message
	of "Sat, 15 Jul 2006 15:42:00 -0700")
Message-ID: <m14pxiqwys.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Sat, 15 Jul 2006 16:40:36 +0200
> Tilman Schmidt <tilman@imap.cc> wrote:
>
>> After installing a 2.6.18-rc1-mm2 kernel without sysctl syscall support
>> on a standard SuSE 10.0 system, I find the following in my dmesg:
>> 
>> > [ 36.955720] warning: process `showconsole' used the removed sysctl system
> call
>> > [ 39.656410] warning: process `showconsole' used the removed sysctl system
> call
>> > [ 43.304401] warning: process `showconsole' used the removed sysctl system
> call
>> > [   45.717220] warning: process `ls' used the removed sysctl system call
>> > [   45.789845] warning: process `touch' used the removed sysctl system call
>> 
>> which at face value seems to contradict the statement in the help text
>> for the CONFIG_SYSCTL_SYSCALL option that "Nothing has been using the
>> binary sysctl interface for some time time now". (sic)
>> 
>> Meanwhile, the second part of that sentence that "nothing should break"
>> by disabling it seems to hold true anyway. The system runs fine, and
>> activating CONFIG_SYSCTL_SYSCALL in the kernel doesn't seem to have any
>> effect apart from changing the word "removed" to "obsolete" in the above
>> messages.
>
> Thanks.
>
> Eric, that tends to make the whole idea inviable, doesn't it?

Close but not quite.

It is the glibc pthread library testing to see if you have an SMP
kernel by greping for SMP in the UTS_VERSION string.  glibc has
always had a fallback to using /proc/sys/kernel/version so it will
behave properly, and uname is really the right interface to this
data.

My next step in testing is to remove that stupid usage from glibc
and see if any other warnings happen.  I don't have time to
finish setting up that test before I leave for Ottowa.

I have already sent Ulrich Drepper a patch to have glibc just use
uname.  The patch was posted to both linux-kernel and libc-alpha.

So yes my understanding was not quite correct, but while I have the
details wrong I don't know that the substance is wrong.  I need to
take this at least to the next step so a convincing argument
can be made for keeping sys_sysctl.

If sys_sysctl really proves to be used and useful we can say
yes people really do use things thing.  We really need to support
this.  We can then revert the 2003 deprecated comment from the header
file and drop patches that do not properly maintain the binary
interface to sys_sysctl.

I don't really care either way but I want a good case made so
sys_sysctl can stop being walking dead.  I hate the attitude
of have a interface from kernel to user space where people
do not care if they break backwards binary compatibility.

Eric
