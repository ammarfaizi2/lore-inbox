Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUITRqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUITRqZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 13:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUITRqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 13:46:25 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:63658 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S266880AbUITRqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 13:46:21 -0400
Message-ID: <414F0F87.9040903@drdos.com>
Date: Mon, 20 Sep 2004 11:12:39 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jmerkey@galt.devicelogics.com
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2 bio sickness with large writes
References: <4148D2C7.3050007@drdos.com> <20040916063416.GI2300@suse.de> <4149C176.2020506@drdos.com> <20040917073653.GA2573@suse.de> <20040917201604.GA12974@galt.devicelogics.com>
In-Reply-To: <20040917201604.GA12974@galt.devicelogics.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey@galt.devicelogics.com wrote:

Jens,

Can you explain the circumstances related to the bio->bi_size callback. 
You stated (and I have observed)
that there may be callbacks from bi_end_io with bi_size set and that 
these should be ignored and
return a value of 1.

Can you explain to me under what circumstances I am likely to see this 
behavior? In other words, would
you explain the bio process start to finish with coalesced IO requests, 
at least as designed. Also, the whole
page and offset sematics in the interface are also somewhat burdensome. 
Wouldn't a more reasonable
interface for async IO be:

address
length
address
length

rather than

page structure
offset in page structure
page structure
offset in page structure

The hardware doesn't care about page mapping above it just needs to see 
addresses (and not always 4 byte aligned addresses)
and lengths for building scatter gather lists. Forcing page sematics 
seems a little orthagonal.

I can assume from the interface as designed that if you pass an offset 
for a page that is not page aligned,
and ask for a 4K write, then you will end up dropping the data on the 
floor than spans beyond the end of the page.

No offense, but this is **BUSTED** behavior for an asynch interface. The 
whole page offset thing is a little
difficult to use and pushes needless complexity to someone just needing 
to submit IO to the disk. I think this
is great for mmap for the VFS layer, and it dure makes it a lot easier 
to submit IO for fs with the mmap layer,
but as a general purpose async layer on top of generic_make_request, 
it's a little tough to use, IMHO.

Please advise,

Jeff





