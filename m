Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWA3T6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWA3T6o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbWA3T6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:58:44 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:60358 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S964932AbWA3T6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:58:43 -0500
Message-ID: <43DE6FE6.40705@cosmosbay.com>
Date: Mon, 30 Jan 2006 20:58:30 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/5] pid: Implement task references.
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com> <m1lkwza479.fsf@ebiederm.dsl.xmission.com> <20060129190539.GA26794@kroah.com> <m1mzhe7l2c.fsf@ebiederm.dsl.xmission.com> <20060130045153.GC13244@kroah.com> <43DDA1E7.5010109@cosmosbay.com> <20060130184302.GA17457@kroah.com>
In-Reply-To: <20060130184302.GA17457@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH a écrit :
> On Mon, Jan 30, 2006 at 06:19:35AM +0100, Eric Dumazet wrote:
>> Example of improvement in kref_put() :
>>
>> [PATCH] kref : Avoid an atomic operation in kref_put() when the last 
>> reference is dropped. On most platforms, atomic_read() is a plan read of 
>> the counter and involves no atomic at all.
> 
> No, we wat to decrement and test at the same time, to protect against
> any race where someone is incrementing right when we are dropping the
> last reference.

Sorry ? Me confused !

What I am saying is :

If a CPUA is doing a kref_put() and refcount == 1, then another CPU *cannot* 
change the refcount, because only one CPU has a valid reference on the object. 
(CPUA )

Proof :

If CPUB cannot kref_put() as well because only CPUA owns a refcount. (If two 
CPUS could kref_put, then counter would become -1 !)

If CPUB is going to do a kref_get() : Not allowed by kref specs  (Rule 3)
(It would mean that both CPUA/B have a reference)

'The kref_get() does not require a lock,
since we already have a valid pointer that we own a refcount for.'

So CPUA and CPUB cannot both own a refcount on a object having refcount=1

If you allow this, then current implementation is buggy as well.

kref->refcount == 1

CPUA :

if (atomic_dec_and_test(&kref->refcount)) {
    returns TRUE condition
[refcount is now 0]

CPUB :
    atomic_inc(&kref->refcount)
[refcount is now 1]

CPUA :
	release(kref); (object freed)

CPUB :
     doing some work on object freed by CPUA. *kaboom*

CPUB : kref_put()
     refcount back to 0 -> object freed twice *kaboom*

> 
> So, thanks, but I'm not going to apply this.
> 
> greg k-h
> 

Me confused.

Yes, kref abstraction is good :)
