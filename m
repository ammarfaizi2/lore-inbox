Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAIRvG>; Tue, 9 Jan 2001 12:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130292AbRAIRup>; Tue, 9 Jan 2001 12:50:45 -0500
Received: from colorfullife.com ([216.156.138.34]:16393 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129383AbRAIRue>;
	Tue, 9 Jan 2001 12:50:34 -0500
Message-ID: <3A5B4E8A.35930AFB@colorfullife.com>
Date: Tue, 09 Jan 2001 18:46:50 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: sct@redhat.com, mingo@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sct wrote:
> We've already got measurements showing how insane this is. Raw IO 
> requests, plus internal pagebuf contiguous requests from XFS, have to 
> get broken down into page-sized chunks by the current ll_rw_block() 
> API, only to get reassembled by the make_request code. It's 
> *enormous* overhead, and the kiobuf-based disk IO code demonstrates 
> this clearly. 

Stephen, I see one big difference between ll_rw_block and the proposed
tcp_sendpage():
You must allocate and initialize a complete buffer head for each page
you want to read, and then you pass the array of buffer heads to
ll_rw_block with one function call.
I'm certain the overhead is the allocation/initialization/freeing of the
buffer heads, not the function call.

AFAICS the proposed tcp_sendpage interface is the other way around:
you need one function call for each page, but no memory
allocation/setup. The memory is allocated internally by the tcp_sendpage
implementation, and it merges requests when possible, thus for a 9000
byte jumbopacket you'd need 3 function calls to tcp_sendpage(MSG_MORE),
but only one skb is allocated and set up.

Ingo is that correct?

--
	Manfred

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
