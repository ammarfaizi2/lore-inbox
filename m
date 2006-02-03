Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWBCODM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWBCODM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 09:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWBCODM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 09:03:12 -0500
Received: from minus.inr.ac.ru ([194.67.69.97]:4538 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1750819AbWBCODL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 09:03:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=i40ro9DjdYiYImS7iU7iFHLaZ/eV7C/799N6kLldA32gUjdvBcO4BvfTaGUe2NUaKUM0eJ1fXNyyMWOrlpSOXOEiXfjztDVpaYPy/agaQBIQZ/YbxkBpz5FbC3yJ576MBUw/snbrCARP9sb4v7OibNM3tSBtJwJocSqGe1+YvUE=;
Date: Fri, 3 Feb 2006 17:02:29 +0300
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 5/7] VPIDs: vpid/pid conversion in VPID enabled case
Message-ID: <20060203140229.GA16266@ms2.inr.ac.ru>
References: <43E22B2D.1040607@openvz.org> <43E23398.7090608@openvz.org> <1138899951.29030.30.camel@localhost.localdomain> <20060203105202.GA21819@ms2.inr.ac.ru> <43E35105.3080208@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E35105.3080208@fr.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> And how bad would it be for openvz to move away from the vpid approach ? do
> you have any plan for it ?

Frankly speaking, using pair (container, pid) was the first thing, which
we did (year ago), so that from viewpoint of core the switch
is not a big deal. :-) However, it was rejected by several reasons:

1. Replacing all the references to pid with pair (container, pid) is quite
expensive. F.e. it is possible that a task has a pid from one container,
but it is in process group and/or session of another container,
and its controlling terminal owner by another container. Grr..
So, the structures are bloated, the functions get additional arguments.
And all this is for no real purpose, the functionality comparing with
VPID is even reduced.

2. It is very inconvenient not to see processes inside VPS from host system.
To do ps, strace, gdb etc. we have to move inside VPS. With VPID approach I can
gdb even "init" process of VPS in a way invisible to VPS, see?
Well, and main problem is that gui administration and monotoring tools,
which were existing for ages stop to work and require a major rewrite.
Does it answer to question about plans for moving away?

To summarize: (container, pid) approach looks clean and consistent.
At first sight I loved it, even thought it will solve some of problems
with inter-container access control. But the devil is in details,
I have to learn this again and again: access control must be separate
of real engine, otherwise you get something which does not satisfy anyone.


> I've also seen that openvz introduces a 'vps_info_t' object, which looks
> like a some virtualization backend. I'm not sure to have well understood
> this framework. What the idea behind it ? is it to handle different
> implementation of the virtualization ?

openvz _is_ a complete implementation of virtualization (http://openvz.org),
dealing with... essentially, everything, including even things like
iptables. The VPID patch is just a small part of the whole openvz,
and vps_info_t is just a part of large structure containing data essential
for this problem.

Alexey

