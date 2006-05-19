Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWESUxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWESUxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWESUxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:53:37 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:59362 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S964837AbWESUxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:53:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=iA2xKNKF7sZJDBnN/IC3EXKbyfSOmlcJdqyWqNEFWcOALLr0VAT1y+dsef+FlVSSNN1jGEu3yo9w9Zd3o2phA3w1AnyNWVCCgb+DFJ+uVdMMjr2udEXTvrNnhtaWD34KZbtD8XrFhcVu98Ztt6D2ku0wMFFA7jlLP++375aMTh4=;
Date: Sat, 20 May 2006 00:52:47 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       herbert@13thfloor.at, serue@us.ibm.com, linux-kernel@vger.kernel.org,
       dev@sw.ru, devel@openvz.org, sam@vilain.net, xemul@sw.ru,
       clg@fr.ibm.com, Daniel Lezcano <dlezcano@fr.ibm.com>
Subject: Re: [PATCH 0/9] namespaces: Introduction
Message-ID: <20060519205247.GA7665@ms2.inr.ac.ru>
References: <20060518154700.GA28344@sergelap.austin.ibm.com> <20060518103430.080e3523.akpm@osdl.org> <20060519124235.GA32304@MAIL.13thfloor.at> <20060519081334.06ce452d.akpm@osdl.org> <m1iro2yo7f.fsf@ebiederm.dsl.xmission.com> <20060519094047.425dced1.akpm@osdl.org> <1148069832.6623.209.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148069832.6623.209.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > Migration of currently-open sockets (for example) would require storing of
> > a lot of state, wouldn't it?
> 
> In a word, yes. :)

Yes. But, actually, it is not "for example". Socket state is really far more
complicated thing than all the rest. I would say, migration of another
objects is mostly trivial thing.

Actually, what Andrew worried about:

> snapshot/restart/migration worry me.  If they require complete
> serialisation of complex kernel data structures then we have a problem,
> because it means that any time anyone changes such a structure they need to
> update (and test) the serialisation.

The answer is: after user space processes referring to objects are suspended,
_surprizingly_, not so much of places, which have trouble with serialization
remain. Actually, no serialization additional to existing one is required.
Sockets are the most complicated, to suspend networking state, after
processes are frozen, we have to:

1. Block access from network.
2. Stop socket timers.

Only after this we can make a coherent snapshot. But it is an exception,
most of objects are in coherent state (all the VM, files etc. etc),
when processes are frozen.


> I don't think the networking guys from either the OpenVZ project or IBM
> were cc'd on this.  Alexey, Daniel, can you elaborate, or point us to
> any existing code?

http://git.openvz.org

linux-2.6-openvz/kernel/cpt/. Particularly, kernel/cpt/cpt_socket*.c.
Hairy, but straighforward.

Alexey
