Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVA3E6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVA3E6h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 23:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVA3E6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 23:58:37 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:45305 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261645AbVA3E6b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 23:58:31 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16892.26990.319480.917561@tut.ibm.com>
Date: Sat, 29 Jan 2005 22:58:22 -0600
To: Andi Kleen <ak@muc.de>
Cc: Tom Zanussi <zanussi@us.ibm.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] relayfs redux, part 2
In-Reply-To: <m1d5volksx.fsf@muc.de>
References: <16890.38062.477373.644205@tut.ibm.com>
	<m1d5volksx.fsf@muc.de>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > Tom Zanussi <zanussi@us.ibm.com> writes:
 > 
 > > Hi,
 > >
 > > This patch is the result of the latest round of liposuction on relayfs
 > > - the patch size is now 44K, down from 110K and the 200K before that.
 > > I'm posting it as a patch against 2.6.10 rather than -mm in order to
 > > make it easier to review, but will create one for -mm once the changes
 > > have settled down.
 > 
 > The logging fast path seems still a bit slow to me. I would like
 > to have a logging macro that is not much worse than a stdio putc,
 > basically something like
 > 
 >           get_cpu();
 >           if (buffer space > N) { 
 >               memcpy(buffer, input, N);
 >               buffer pointer += N;
 >           } else { 
 >               FreeBuffer(input, N); 
 >           }    
 >           put_cpu();
 > 

I think what we have now is somewhat similar, except that we wanted to
separate grabbing a slot in the buffer from the memcpy because some
applications such as ltt want to be able to directly write into the
slot without having to copy it into another buffer first.  How about
something like this for relay reserve, with the local_add_return()
gone since we're assuming the client protects the buffer properly for
whatever it's doing:

relay_reserve(length)
{
	if (buffer->offset + length <= bufsize) {
		reserved = buffer->data + buffer->offset;
		buffer->offset += length;
	} else { /* slow path */
		reserved = switch_buffer(length);
		if (reserved)
			buffer->offset += length;
	}

	return reserved;
}

If you set up the channel to use MODE_CONTINUOUS, meaning continuously
cycle around the buffer, your logging function or macro would look
something like this:

simplest_write(data, length)
{
	get_cpu();
	
	reserved = relay_reserve();
	memcpy(reserved, data, length);

	put_cpu();
}

Clients who want to stop logging if the buffers are full would have an
extra test for when the reserve fails, which can never happen in
continuous mode:

/* uses MODE_NO_OVERWRITE */
ltt_write(data, length)
{
	local_irq_save();

	reserved = relay_reserve();
	if (reserved) { /* if NULL, buffer full */
		memcpy(reserved, item1, len1);
		.
		.
		.
		memcpy(reserved, itemN, lenN);
	}
	
	local_irq_restore();
}

 > This would need interrupt protection only if interrupts can access
 > it, best you use separate buffers for that too.

Not sure what you mean by separate buffers for that too.  Can you
expand on that a little?

Thanks,

Tom

