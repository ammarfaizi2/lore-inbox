Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWBKKMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWBKKMz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 05:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWBKKMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 05:12:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2756 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751391AbWBKKMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 05:12:54 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 20/20] proc: Update /proc to support multiple pid
 spaces.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j88mg8l.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biwmg4p.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y80ol1gh.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0bcl1ai.fsf_-_@ebiederm.dsl.xmission.com>
	<m1psm0l170.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkwol133.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hd7cl0yp.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5i0l0ua.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xsol0p9.fsf_-_@ebiederm.dsl.xmission.com>
	<m14q3cl0mk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zml4jlzk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1vevsjlxa.fsf_-_@ebiederm.dsl.xmission.com>
	<m1r76gjlua.fsf_-_@ebiederm.dsl.xmission.com>
	<m1mzh4jlrl.fsf_-_@ebiederm.dsl.xmission.com>
	<m1irrsjlnn.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ek2gjlgh.fsf_-_@ebiederm.dsl.xmission.com> <43ECFA46.3050001@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 11 Feb 2006 03:10:16 -0700
In-Reply-To: <43ECFA46.3050001@sw.ru> (Kirill Korotaev's message of "Fri, 10
 Feb 2006 23:40:38 +0300")
Message-ID: <m1accyxl2v.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> Hello,
>
>> This patch does a couple of things.
>> - It splits proc into proc and proc_sysinfo
>> - It adds pspace support to proc
>> - It adds getattr methods to ensure proc has the proper hard link count.
>> - It increases the size of a couple of buffers by one to avoid buffer overflow
>> - It moves /proc/mounts and /proc/loadavg into the proc filesystem from
> proc_sysinfo
>> Sorry for the big patch.  When I start feeding this changes seriously I will
>> split this patch.
>> The split of /proc into mutliple filesystems works well however it comes
>> with one downsides.  There are now some directories where cd -P <subdir>/..
>> is not a noop.  Basically it is doing the equivalent of following symlinks
>> into an internal kernel mount.  It is well defined and safe behaviour but
>> I'm not certain if it is desirable.
>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> This one is really ugly.

It is certainly to much at one time, and the code while semanticly 
interesting is still has significant issues with the implementation.
But a lot of the ugliness is inherent in the current implementation of
/proc and not what I am trying to do with it.

> And it is also controversial to your own idea of having separate namespaces, 
> but introduces a pointer to proc_mnt in pspace.

An instance of /proc being connected to a pid space is perfectly
natural.  /proc is after all the filesystem that reports what is in a
pspace.

I freely admit the way I am using the internal mount of proc is
wrong, and is something that needs to be resolved before I submit
this for kernel inclusion.  I was attempting to solve the problem
of having duplicate dcache entries in my recursive structure.
Unfortunately it was one of those clever solutions that only gets
you 99% of the way to where you want to go.

> You have many namespaces to which task_struct refers.
> Do you want proc to work in any configuration of namespaces?
Yes.

> Then you can't have pointers to proc_mnt from namespaces.
> Well, I understand that proc is the most painfull for you... yeah...

proc is the painful for any pid change in how pids are dealt with.
So far I have not seen a single implementation that cleanly and
correctly addresses all of the issues (including mine :)

Eric


