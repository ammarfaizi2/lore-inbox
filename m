Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbWBHApi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWBHApi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 19:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWBHApi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 19:45:38 -0500
Received: from minus.inr.ac.ru ([194.67.69.97]:57783 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1030220AbWBHAph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 19:45:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=aB3vAVpHmM0mewV28dr/dum7SSt035AdLl5DRwaA2fo4DDGWdAvaILBNPDrjYYdSR6Tbd+SFXZKu73kkqrFl5RtwMD0++RKXCasIxAdJZf66rA5clfXXQR+P8LKqw7LWUnuIoB7lnwJtCTaHWEj3bqaOdhzNhdHSeBGWgp/n/Oo=;
Date: Wed, 8 Feb 2006 03:43:25 +0300
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Andi Kleen <ak@suse.de>, Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: The issues for agreeing on a virtualization/namespaces implementation.
Message-ID: <20060208004325.GA15061@ms2.inr.ac.ru>
References: <43E7C65F.3050609@openvz.org> <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com> <20060207201908.GJ6931@sergelap.austin.ibm.com> <43E90716.4020208@watson.ibm.com> <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com> <43E92EDC.8040603@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E92EDC.8040603@watson.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> >2) What is the syscall interface to create these namespaces?
> >   - Do we add clone flags?  
> >     (Plan 9 style)
> 
> Like that approach .. flexible .. particular when one has well specified 
> namespaces.
> 
> >   - Do we add a syscall (similar to setsid) per namespace?
> >     (Traditional unix style)?
> 
> Where does that approach end .. what's wrong with doing it at clone() time ?

That most of those namespaces need a special setup rather than a plain copy?

F.e. what are you going to do with NETWORK namespace? The only valid thing
to do is to prepare a new context and to configure its content (addresses,
routing tables, iptables...) later. So that, in this case it is natural
to inherit the context through clone() and to create new context
with a separate syscall.

Seems, only PID space needs to be setup at clone time. All the rest of
suggested namespaces are more convenient to change with separate syscalls.

I would suggest to combine both approaches. Those namespaces, which can be
naturally copied while clone() (f.e. the best example is already existing
CLONE_NEWNS) deserve a clone() flag. The rest are preserved through clone()
and forked and configured later.

Alexey
