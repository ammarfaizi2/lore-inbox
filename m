Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWBGXSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWBGXSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWBGXSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:18:39 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:38118 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030249AbWBGXSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:18:38 -0500
Message-ID: <43E92AC9.3090308@watson.ibm.com>
Date: Tue, 07 Feb 2006 18:18:33 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: Rik van Riel <riel@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clg@fr.ibm.com, haveblue@us.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org> <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com> <43E92602.8040403@vilain.net>
In-Reply-To: <43E92602.8040403@vilain.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> Hubertus Franke wrote:
> 
>> The container is just an umbrella object that ties every "virtualized" 
>> subsystem together.
> 
> 
> I like this description; it matches roughly with the concepts as
> presented by vserver; there is the process virtualisation (vx_info), and
> the network virtualisation (nx_info) of Eric's that has been integrated
> to the vserver 2.1.x development branch.  However the vx_info has become
> the de facto umbrella object space as well.  These could almost
> certainly be split out without too much pain or incurring major
> rethinks.
> 
> Sam.
> 


Agreed.. here are some issued we learned from other projects that had
similar interception points.

Having a central umbrella object (let's stick to the name container)
is useful, but being the only object through which every access has to
pass may have drawbacks..

task->container->pspace->pidmap[offset].page   implies potential
cachemisses etc.

If overhead becomes too large, then we can stick (cache) the pointer
additionally in the task struct. But ofcourse that should be carefully
examined on a per subsystem base...

==
Another thing to point out is that container's can have overlaps.

C/R should be a policy thing. So if each "subsystem"

>  Quote Eric>>>
> PIDS
> UIDS
> SYSVIPC
> NETWORK
> UTSNAME
> FILESYSTEM

is represented as a NAMESPACE, then one can pick and choose as a
policy how these constitute at a conceptual level as a container.
You want something migratable you better make sure that
container implies unique subsystems.
Maybe you want to nest containers, but only want to create a
separate pidspaces for performance isolation (see planetlab work
with vserver).
So, there are many possibilities, that might make perfect sense
for different desired solutions and it seems with the
clone ( CLONE_FLAGS_NSPACE_[PIDS/UIDS/SYS.../FS] ) one gets a solution
that is flexible, yet embodies may requirements.....

-- Hubertus



