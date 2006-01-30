Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWA3FTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWA3FTq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 00:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWA3FTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 00:19:45 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:37994 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751243AbWA3FTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 00:19:45 -0500
Message-ID: <43DDA1E7.5010109@cosmosbay.com>
Date: Mon, 30 Jan 2006 06:19:35 +0100
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
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com> <m1lkwza479.fsf@ebiederm.dsl.xmission.com> <20060129190539.GA26794@kroah.com> <m1mzhe7l2c.fsf@ebiederm.dsl.xmission.com> <20060130045153.GC13244@kroah.com>
In-Reply-To: <20060130045153.GC13244@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------020306050307020002060906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020306050307020002060906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Greg KH a écrit :
> On Sun, Jan 29, 2006 at 02:58:51PM -0700, Eric W. Biederman wrote:
>> Greg KH <greg@kroah.com> writes:
>>
>>> On Sun, Jan 29, 2006 at 12:22:34AM -0700, Eric W. Biederman wrote:
>>>> +struct task_ref
>>>> +{
>>>> +	atomic_t count;
>>> Please use a struct kref here, instead of your own atomic_t, as that's
>>> why it is in the kernel :)
>>>
>>>> +	enum pid_type type;
>>>> +	struct task_struct *task;
>>>> +};
>>> thanks,
>> I would rather not. Whenever I look at struct kref it seems to be an over
>> abstraction, and as such I find it confusing to work with.  I know
>> whenever I look at the sysfs code I have to actively remind myself
>> that the kref in the structure is not a pointer to a kref.
>>
>> What does the kref abstraction buy?  How does it simplify things?
>> We already have equivalent functions in atomic_t on which it is built.
> 
> It ensures that you get the logic of the reference counting correctly.
> It forces you to do the logic of the get and put and release properly.
> 
> To roughly quote Andrew Morton, "When I see a kref, I know it is used
> properly, otherwise I am forced to read through the code to see if the
> author got the reference counting logic correct."
> 
> It costs _nothing_ to use it, and let's everyone know you got the logic
> correct.
> 
> So don't feel it is a "abstraction", it's a helper for both the author
> (who doesn't have to get the atomic_t calls correct), and for everyone
> else who has to read the code.
> 

kref abstraction is good.

Its current implementation seems straightforward, so I understand some devs 
think they can 'just use an atomic_t' themselves.

But using kref is better because some generic improvement could be done at 
kref level and you dont need to parse all kernel sources to change atomic_t to 
kref...

Example of improvement in kref_put() :

[PATCH] kref : Avoid an atomic operation in kref_put() when the last reference 
is dropped. On most platforms, atomic_read() is a plan read of the counter and 
involves no atomic at all.


Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--------------020306050307020002060906
Content-Type: text/plain;
 name="kref.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kref.patch"

--- a/lib/kref.c	2006-01-30 06:11:04.000000000 +0100
+++ b/lib/kref.c	2006-01-30 06:13:32.000000000 +0100
@@ -52,7 +52,12 @@
 	WARN_ON(release == NULL);
 	WARN_ON(release == (void (*)(struct kref *))kfree);
 
-	if (atomic_dec_and_test(&kref->refcount)) {
+	/*
+	 * if current count is one, we are the last user and can release object
+	 * right now, avoiding an atomic operation on 'refcount'
+	 */
+	if ((atomic_read(&kref->refcount) == 1) ||
+	    (atomic_dec_and_test(&kref->refcount))) {
 		release(kref);
 		return 1;
 	}

--------------020306050307020002060906--
