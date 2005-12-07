Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbVLGTBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbVLGTBH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbVLGTBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:01:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24761 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751462AbVLGTBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:01:06 -0500
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
In-Reply-To: <1133978996.24344.42.camel@localhost>
References: <20051114212341.724084000@sergelap>
	 <m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
	 <1133977623.24344.31.camel@localhost>
	 <1133978128.2869.51.camel@laptopd505.fenrus.org>
	 <1133978996.24344.42.camel@localhost>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 20:00:48 +0100
Message-Id: <1133982048.2869.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > hmm wonder if it's not just a lot simpler to introduce a split in
> > "kernel pid" and "userspace pid", and have current->pid and
> > current->user_pid for that.
> > 
> > Using accessor macros doesn't sound like it gains much here.. (but then
> > I've not seen the full picture and you have)
> 
> My first instinct was to introduce functions like get_user_pid() and
> get_kernel_pid() which would effectively introduce the same split.
> Doing that, we could keep from even referencing ->user_pid in normal
> code, and keep things small and simpler for people like the embedded
> folks.

well I don't see the point for the abstraction... get_kernel_pid() is no
better or worse than using current->pid directly, unless you want to do
"deep magic". 

> For the particular application that we're thinking of, we really don't
> want "user pid" and "kernel pid" we want "virtualized" and
> "unvirtualized", or "regular old pid" and "fancy new virtualized pid".

same thing, different name :)

> So, like in the global pidspace (which can see all pids and appears to
> applications to be just like normal) you end up returning "kernel" pids
> to userspace.  That didn't seem to make sense.  

hmm this is scary. If you don't have "unique" pids inside the kernel a
lot of stuff will subtly break. DRM for example (which has the pid
inside locking to track ownership and recursion), but I'm sure there's
many many cases like that. I guess the address of the task struct is the
ultimate unique pid in this sense.... but I suspect the way to get there
is first make a ->user_pid field, and switch all userspace visible stuff
to that, and then try to get rid of ->pid users one by one by
eliminating their uses... 

but I'm really afraid that if you make the "fake" pid visible to normal
kernel code, too much stuff will go bonkers and end up with an eternal
stream of security hazards. "Magic" hurts here, and if you don't do
magic I don't see a reason to add an abstraction which in itself doesn't
mean anything or doesn't abstract anything....

