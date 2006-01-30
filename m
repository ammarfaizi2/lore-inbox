Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWA3Uqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWA3Uqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWA3Uqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:46:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59014 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964969AbWA3Uqh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:46:37 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/5] pid: Implement task references.
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>
	<m1lkwza479.fsf@ebiederm.dsl.xmission.com>
	<20060129190539.GA26794@kroah.com>
	<m1mzhe7l2c.fsf@ebiederm.dsl.xmission.com>
	<20060130045153.GC13244@kroah.com> <43DDA1E7.5010109@cosmosbay.com>
	<20060130184302.GA17457@kroah.com> <43DE6FE6.40705@cosmosbay.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 30 Jan 2006 13:45:48 -0700
In-Reply-To: <43DE6FE6.40705@cosmosbay.com> (Eric Dumazet's message of "Mon,
 30 Jan 2006 20:58:30 +0100")
Message-ID: <m1bqxt5ts3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> writes:

> Greg KH a écrit :
>> On Mon, Jan 30, 2006 at 06:19:35AM +0100, Eric Dumazet wrote:
>>> Example of improvement in kref_put() :
>>>
>>> [PATCH] kref : Avoid an atomic operation in kref_put() when the last
>>> reference is dropped. On most platforms, atomic_read() is a plan read of the
>>> counter and involves no atomic at all.
>> No, we wat to decrement and test at the same time, to protect against
>> any race where someone is incrementing right when we are dropping the
>> last reference.
>
> Sorry ? Me confused !

Largely I think you have the right of it, that the optimization is
correct.  My biggest complaint is that the common case is going to be
several references to the data structure.  Releasing the references
will always be slow.  To do the read you need to get the value into
the cache line.

So it looks to me like you are optimizing the wrong case and
bloating the icache with unnecessary code.

Eric


