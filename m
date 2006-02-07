Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWBGWI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWBGWI6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWBGWI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:08:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63889 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030184AbWBGWI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:08:58 -0500
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: The issues for agreeing on a virtualization/namespaces
 implementation.
References: <43E7C65F.3050609@openvz.org>
	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
	<20060207201908.GJ6931@sergelap.austin.ibm.com>
	<43E90716.4020208@watson.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Feb 2006 15:06:51 -0700
In-Reply-To: <43E90716.4020208@watson.ibm.com> (Hubertus Franke's message of
 "Tue, 07 Feb 2006 15:46:14 -0500")
Message-ID: <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think I can boil the discussion down into some of the fundamental
questions that we are facing.

Currently everyone seems to agree that we need something like
my namespace concept that isolates multiple resources.

We need these for 
PIDS
UIDS
SYSVIPC
NETWORK
UTSNAME
FILESYSTEM
etc.

The questions seem to break down into:
1) Where do we put the references to the different namespaces?
   - Do we put the references in a struct container that we reference from struct task_struct?
   - Do we put the references directly in struct task_struct?

2) What is the syscall interface to create these namespaces?
   - Do we add clone flags?  
     (Plan 9 style)
   - Do we add a syscall (similar to setsid) per namespace?
     (Traditional unix style)?
   - Do we in addition add syscalls to manipulate containers generically?

   I don't think having a single system call to create a container and a new
   instance of each namespace is reasonable as that does not give us a
   path into the future when we create yet another namespace.

   If we have one syscall per each namespace why would we need a container
   structure?

3) How do we refer to namespaces and containers when we are not members?
   - Do we refer to them indirectly by processes or other objects that
     we can see and are members?
   - Do we assign some kind of unique id to the containers?
  

4) How do we implement each of these namespaces?
   Besides being maintainable are there other constraints?


5) How do we control the resource inside a namespace starting
   from a process that is outside of that namespace?
   - The filesystem mount namespace gave an interesting answer.
     So it is quite possible other namespaces will give
     equally interesting and surprising answers.


6) How do we do all of this efficiently without a noticeable impact on
   performance?
   - I have already heard concerns that I might be introducing cache
     line bounces and thus increasing tasklist_lock hold time.
     Which on big way systems can be a problem.

7) How do we allow a process inside a container to create containers
   for it's children?
   - In general this is trivial but there are a few ugly issues
     here.

I think these are the key questions of the conversation.


Personally so long as we get true namespaces, implemented in a
performant and maintainable way that a process from the inside can't
distinguish from what we have now I have no hard requirements.

   
Eric
