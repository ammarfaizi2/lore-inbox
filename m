Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWA0Umo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWA0Umo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbWA0Umo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:42:44 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:19145 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1161018AbWA0Umn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:42:43 -0500
Date: Fri, 27 Jan 2006 21:41:58 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       keyrings@linux-nfs.org
Subject: Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060127204158.GA4754@hardeman.nu>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	keyrings@linux-nfs.org
References: <20060127092817.GB24362@infradead.org> <1138312694656@2gen.com> <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6403.1138392470@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.11
X-SA-Score: -2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 08:07:50PM +0000, David Howells wrote:
>Christoph Hellwig <hch@infradead.org> wrote:
>
>> This is ugly as hell.  If we decided to add it it really needs a major
>> cleanup, fitting into linux style and removal of unused functionality,
>> the assembly bits needs to move to an asm/ header, etc.
>
>Which would make it harder to compare against the original, and so potentially
>harder to track bug fixes in the original was my thinking.

I think it might still work quite well with a subset since each function 
is quite self-contained and a bugfix in one function would still be 
quite easy to match to the corresponding function in the in-kernel code 
even if it has been refactored and moved around.

>> But to be honest I'd say anything that requires bigints shouldn't go into
>> the kernel at all.  Could someone explain why they want dsa support in
>> kernelspace?
>
>Well... I'd like to revisit module signing at some point, though I imagine
>it'll cause the LKML to melt again by those who think that I shouldn't have
>the right to sign my modules because they imagine it impinges on their
>rights:-) But I suspect the reason David wants this is so that he can encrypt
>something with keys that he's not actually permitted to retrieve
>directly. David?

The reason that I wanted DSA-keys supported by the in-kernel key stuff 
is that it allows for some cool stuff which is either impossible or very 
hard to do otherwise.

For example, a backup daemon which wishes to store the backup on another 
host using ssh. Usually this is solved by storing an unencrypted key in 
the fs or by providing a connection to a ssh-agent which has been 
preloaded with the proper key(s). Both are quite inelegant solutions. 
With the in-kernel support, the daemon can request the key using the 
request_key call, and (provided proper scripts are written), the user 
who controls the relevant key can supply it. This in turn means that the 
backup daemon can sign using the key and read its public parts but not 
the private key.

So yes, that is one example of doing "something" with keys that the 
process is not allowed to retrieve directly (the key itself could be 
supplied from removable storage or something and given a few minutes of 
time-to-live).

It also means that users would not have to run ssh-agent and would not 
have to bother with making sure that only one instance of ssh-agent is 
running even if they are logged in multiple times.

The in-kernel key management also protects the key against many of the 
different ways in which a user-space daemon could be attacked (ptrace, 
swap-out, coredump, etc).

In addition, the dsa key code can be used to implement signed binaries 
and signed modules.

For now I'll create a version of mpilib which has been stripped down to 
only the functions that are in use by the dsa-crypto stuff, hopefully 
this will substantially reduce the size and amount of code. I'll get 
back when I have some results.

Regards,
David
