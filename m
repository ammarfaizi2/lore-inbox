Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVDZHUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVDZHUI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVDZHTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:19:33 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:28906 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261218AbVDZHSz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:18:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WtnnuoD9RMfbYIkfm2AAQ23hSOkITmi/jXenQb12QQSbJ78HVWNJ9OJdUJ4wrTpMB11gLOqSK1hso13zUhkZd8tj0chtnT4iebe7znM2Jm0vSCV+NS2iduVlqMdMUIFRcvYvedK8cNepkS3wulLrKVNNHZ7SlLyWSz855coY6zc=
Message-ID: <df35dfeb05042600184c683c8c@mail.gmail.com>
Date: Tue, 26 Apr 2005 00:18:54 -0700
From: Yum Rayan <yum.rayan@gmail.com>
Reply-To: Yum Rayan <yum.rayan@gmail.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [PATCH linux-2.6.12-rc2-mm3] smc91c92_cs: Reduce stack usage in smc91c92_event()
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org,
       dahinds@users.sourceforge.net, rddunlap@osdl.org
In-Reply-To: <200504231821.31309.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <df35dfeb05042115021c24638b@mail.gmail.com>
	 <200504221122.51579.vda@port.imtp.ilyichevsk.odessa.ua>
	 <20050423001228.GA6418@wohnheim.fh-wedel.de>
	 <200504231821.31309.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/05, Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> On Saturday 23 April 2005 03:12, Jörn Engel wrote:
> 
> > > 1) struct is unnamed and local to function
> > > 2) Variables do not change their type, the just sit in local-> now.
> > >    I can just add 'local->' to each affected variable,
> > >    without "it was an object, now it is a pointer" changes.
> > >    No need to replace . with ->, remove &, etc.
> >
> > I'd have proposed the same, before reading further down in the patch.
> > Basically, the driver is full of duplication, so the exact same struct
> > can be used several times.  Therefore, the downsides of your approach
> > seem to prevail.
> 
> What downsides? I must admit I do not understand your answer here.
> 
> Let me stay on the subject of converting large stack onjects
> to kmalloc()ed ones, without reference to current state
> of code in a particular module.
> 
> Basically, these objects are local to function. We do not

And seem to be always used in conjuction with each other, not alone
across various functions in this driver alone but also across various
card services drivers.

> introduce struct as an 'object'. It merely aggregates
> all locals we decided to move to kmalloc space,
> only because it's easier that way to allocate and reference
> all of them in C.
> 
> Thus, even if there are many functions with similar
> set of locals, it makes little sense to declare common struct.
> IOW, I wouldn't do this:
> 
> struct big {
>        large_t large;
>        huge_t huge;
> };
> 
> int f() {
>        struct big *local;
>        local = kmalloc(sizeof(big),...);
>        ...
> }
> 
> int g() {
>        struct big *local;
>        local = kmalloc(sizeof(big),...);
>        ...
> }
> 
> For one, what will happen when you will need to add
> another local in one function only?

struct another_local_struct *another_local;
another_local = kmalloc(sizeof(sruct another_local_struct),...);

or if single kmalloc is preferred, then:

struct another_big_struct {
  struct old_big_struct old_big;
  struct new_big_struct new_big;
} ;

I'd agree with your suggestion had it been "struct big", or "struct
huge" or "struct stack" or something like that, but does not seem
appropriate in this particular case.

Regards,
Rayan
