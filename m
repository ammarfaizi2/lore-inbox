Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVDWPVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVDWPVt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 11:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVDWPVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 11:21:48 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:20971 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261612AbVDWPVo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 11:21:44 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH linux-2.6.12-rc2-mm3] smc91c92_cs: Reduce stack usage in smc91c92_event()
Date: Sat, 23 Apr 2005 18:21:30 +0300
User-Agent: KMail/1.5.4
Cc: Yum Rayan <yum.rayan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org, dahinds@users.sourceforge.net,
       rddunlap@osdl.org
References: <df35dfeb05042115021c24638b@mail.gmail.com> <200504221122.51579.vda@port.imtp.ilyichevsk.odessa.ua> <20050423001228.GA6418@wohnheim.fh-wedel.de>
In-Reply-To: <20050423001228.GA6418@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504231821.31309.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 April 2005 03:12, Jörn Engel wrote:

> > 1) struct is unnamed and local to function
> > 2) Variables do not change their type, the just sit in local-> now.
> >    I can just add 'local->' to each affected variable,
> >    without "it was an object, now it is a pointer" changes.
> >    No need to replace . with ->, remove &, etc.
> 
> I'd have proposed the same, before reading further down in the patch.
> Basically, the driver is full of duplication, so the exact same struct
> can be used several times.  Therefore, the downsides of your approach
> seem to prevail.

What downsides? I must admit I do not understand your answer here.

Let me stay on the subject of converting large stack onjects
to kmalloc()ed ones, without reference to current state
of code in a particular module.

Basically, these objects are local to function. We do not
introduce struct as an 'object'. It merely aggregates
all locals we decided to move to kmalloc space,
only because it's easier that way to allocate and reference
all of them in C.

Thus, even if there are many functions with similar
set of locals, it makes little sense to declare common struct.
IOW, I wouldn't do this:

struct big {
	large_t	large;
	huge_t huge;
};

int f() {
	struct big *local;
	local = kmalloc(sizeof(big),...);
	...
}

int g() {
	struct big *local;
	local = kmalloc(sizeof(big),...);
	...
}

For one, what will happen when you will need to add
another local in one function only?

Instead, I'd do it like I described in previous mail:

int f() {
	struct {
		large_t	large;
		huge_t huge;
	} *local;
	local = kmalloc(sizeof(*local),...);
	...
}

int g() {
	struct {
		large_t	large;
		huge_t huge;
	} *local;
	local = kmalloc(sizeof(*local),...);
	...
}
--
vda

