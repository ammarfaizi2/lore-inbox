Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWA3Gqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWA3Gqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 01:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWA3Gqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 01:46:46 -0500
Received: from smtpout.mac.com ([17.250.248.72]:35323 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751257AbWA3Gqp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 01:46:45 -0500
In-Reply-To: <43DDA836.7070600@cosmosbay.com>
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com> <m1lkwza479.fsf@ebiederm.dsl.xmission.com> <20060129190539.GA26794@kroah.com> <m1mzhe7l2c.fsf@ebiederm.dsl.xmission.com> <20060130045153.GC13244@kroah.com> <43DDA1E7.5010109@cosmosbay.com> <AB74DF4E-5563-4449-8194-315AA4CCD7FE@mac.com> <43DDA836.7070600@cosmosbay.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <603638A5-E0A5-4B75-9485-A56B1C145277@mac.com>
Cc: Greg KH <greg@kroah.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/5] pid: Implement task references.
Date: Mon, 30 Jan 2006 01:46:11 -0500
To: Eric Dumazet <dada1@cosmosbay.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 30, 2006, at 00:46, Eric Dumazet wrote:
> Kyle Moffett a écrit :
>> On Jan 30, 2006, at 00:19, Eric Dumazet wrote:
>>> -    if (atomic_dec_and_test(&kref->refcount)) {
>>> +    /*
>>> +     * if current count is one, we are the last user and can  
>>> release object
>>> +     * right now, avoiding an atomic operation on 'refcount'
>>> +     */
>>> +    if ((atomic_read(&kref->refcount) == 1) ||
>> Uhh, I think you got this test reversed.  Didn't you mean != 1?   
>> Otherwise you only do the dec_and_test when the refcount is one,  
>> which means that you leak everything kref-ed.
>
> Not at all :)
>
> Your mail is just another proof why kref is a good abstraction :)
>
> If you are the last user of a kref, (refcount = 1), then
> you are sure that nobody else but you is using the object, and as  
> we are kref_put() this object, the atomic_dec_and-test *will* set  
> the count the object and you are going to release() object.
>
> The release() function is not going to look at kref_count again,  
> just free the resources and the object.

OHHH, I see where I got confused.  The indentation was bad, dunno if  
it was my end or yours, so I misread it as this:

if (atomic_read(...) == 1) {
	atomic_dec_and_test(...);
	...
}

instead of this:

if (atomic_read(...) == 1 ||
		atomic_dec_and_test(...)) {
	...
}

This should teach me not to reply this late at night.  Sorry for the  
confusion.

Cheers,
Kyle Moffett

--
They _will_ find opposing experts to say it isn't, if you push hard  
enough the wrong way.  Idiots with a PhD aren't hard to buy.
   -- Rob Landley



