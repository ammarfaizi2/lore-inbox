Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWA3Fqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWA3Fqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 00:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWA3Fqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 00:46:31 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:50330 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751247AbWA3Fqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 00:46:30 -0500
Message-ID: <43DDA836.7070600@cosmosbay.com>
Date: Mon, 30 Jan 2006 06:46:30 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Greg KH <greg@kroah.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 1/5] pid: Implement task references.
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com> <m1lkwza479.fsf@ebiederm.dsl.xmission.com> <20060129190539.GA26794@kroah.com> <m1mzhe7l2c.fsf@ebiederm.dsl.xmission.com> <20060130045153.GC13244@kroah.com> <43DDA1E7.5010109@cosmosbay.com> <AB74DF4E-5563-4449-8194-315AA4CCD7FE@mac.com>
In-Reply-To: <AB74DF4E-5563-4449-8194-315AA4CCD7FE@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett a écrit :
> On Jan 30, 2006, at 00:19, Eric Dumazet wrote:
>> -    if (atomic_dec_and_test(&kref->refcount)) {
>> +    /*
>> +     * if current count is one, we are the last user and can release 
>> object
>> +     * right now, avoiding an atomic operation on 'refcount'
>> +     */
>> +    if ((atomic_read(&kref->refcount) == 1) ||
> 
> Uhh, I think you got this test reversed.  Didn't you mean != 1?  
> Otherwise you only do the dec_and_test when the refcount is one, which 
> means that you leak everything kref-ed.
> 

Not at all :)

Your mail is just another proof why kref is a good abstraction :)

If you are the last user of a kref, (refcount = 1), then
you are sure that nobody else but you is using the object, and as we are 
kref_put() this object, the atomic_dec_and-test *will* set the count the 
object and you are going to release() object.

The release() function is not going to look at kref_count again, just free the 
resources and the object.

Maybe a change in the documentation is necessary to explain this point 
(release() can e called while the apparent krefcount is 1)

Or in kref_put doing this :

if (atomic_read(&kref->refcount) == 1) {
	atomic_set(&kref->refcount, 0);
	release(kref);
}
if (atomic_dec_and_test(&kref->refcount)) {
         release(kref);
         return 1;
}


Eric

