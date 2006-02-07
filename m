Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWBGUTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWBGUTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 15:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWBGUTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 15:19:13 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:58511 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964862AbWBGUTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 15:19:12 -0500
Date: Tue, 7 Feb 2006 14:19:08 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Sam Vilain <sam@vilain.net>, Rik van Riel <riel@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clg@fr.ibm.com, haveblue@us.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
Message-ID: <20060207201908.GJ6931@sergelap.austin.ibm.com>
References: <43E7C65F.3050609@openvz.org> <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E8D160.4040803@watson.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hubertus Franke (frankeh@watson.ibm.com):
> The vpid approach has the drawbacks of having to identify the conversion 
> spots
> of all vpid vs. pid semantics. On the otherhand it does take advantage
> of the fact that no virtualization has to take place until a "container"
> has been migrated, thus rendering most of the vpid<->pid calls to be
> noops.
> 
> What I like about the pspace approach is that it explicitely defines in the 
> code
> when I am using a different pspace for the lookup. That is kind of hidden in
> the vpid/pid approach.

I agree with this.  From a maintenance pov, imagining making a minor
change to some pid-related code, if I see something doing effectively
"if (pspace1 == pspace2 && pid1==pid2)" that is clear, whereas trying
to remember whether I'm supposed to return the pid or vpid can get
really confusing.  We actually had some errors with that while we were
developing the first vpid patchset we posted in december.

I believe that from a vserver point of view, either approach will work.
You either create a new pspace and make 'init' pid 1 in that pspace, or,
in the openvz approach, you start virtualizing with a hashtable so
userspace in the new vserver/container/vz/whateveritscalled sees that
init as pid1, while the rest of the system sees it as pid 3270 or
something.

Likewise, for checkpoint/restore and migration, either approach works.
All we really need is, on restore/migrate, to be able to create
processes with their original pids, so we can do that either with real
pids in a new container, or virtualized pids faked for process in the
same vz.

Are there other uses of pid virtualization which one approach or the
other cannot accomodate?

If not, then I for one lean towards the more maintainable code.  (which
I'm sure we're not agreed on is Eric's, but imvho it is)

-serge
