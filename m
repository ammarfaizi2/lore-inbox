Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265884AbUATXYC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265885AbUATXYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:24:02 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:40066 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S265884AbUATXX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:23:57 -0500
Message-ID: <400DAA76.2080103@sgi.com>
Date: Tue, 20 Jan 2004 16:23:50 -0600
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: akpm@osdl.org, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix updates
References: <200401152154.i0FLscIG023452@fsgi900.americas.sgi.com> <20040116144132.A24555@infradead.org> <400D6A5B.7090009@sgi.com> <20040120180851.A18872@infradead.org> <400D8BBF.7070005@sgi.com> <20040120202132.A20668@infradead.org>
In-Reply-To: <20040120202132.A20668@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Tue, Jan 20, 2004 at 02:12:47PM -0600, Patrick Gefre wrote:
>  
>
>>Guess I don't understand your point. Do you want us to create separate 
>>functions for soft-struct and bridge address
>>and TIO and non-TIO - 4 functions for each register access, rather than 1 ?
>>    
>>
>
>The right fix would be to only have one, and that one would take the
>bridge_t.  If you really want to have one that takes the pcibr_soft, too
>make it a small wrapper.  But even that would be two and not four, where
>do the other two come from?
>  
>
I had one for bridge address/TIO, one for bridge address/nonTIO, one for 
soft address/TIO and one for soft address/nonTIO.
I thought that was what you were proposing. In any event, here's how the 
basic code looks (leaving out type defs/error checking/
etc) - the wrapper is embedded in the macro - note that we would always 
like to use the soft struct because it doesn't cost us a PIO
but in the event that the soft struct is not available the bridge 
address must be used:

#define SET_TYPE_AND_PTR(ptr, type, bridge) \
    if ( IS_IOADDR(ptr) ) { \
        if ( IS_TIO(ptr->id) ) \
            type = BT_TIO; \
        else \
            type = BT_PIC; \
        bridge_addr = ptr; \
    } else { \
        type = ptr->bs_bridge_type; \
        bridge_addr = ptr->bs_base; \
    }

void *
pcireg_xxx_get(void *ptr)
{
    SET_TYPE_AND_PTR(ptr, &type, bridge);

    switch (type ) {
        case BT_TIO:
            return bridge_addr->ti_xxx;

        case BT_PIC:
            return bridge->addr->pic_xxx;

        default:
            /* */
    }
}


Is this what you are suggesting ??

void *
pcireg_xxx_get(void *ptr)
{
    if ( IS_IOADDR(ptr) )
        return REAL_pcireg_xxx_get(ptr, IS_TIO(ptr) ? BT_TIO : BT_PIC);
    else
        return REAL_pcireg_xxx_get(ptr->bs_base, ptr->bs_bridge_type);
       
}

void *
REAL_pcireg_xxx_get(void *ptr, int type)
{
    switch (type ) {
        case BT_TIO:
            return bridge_addr->ti_xxx;

        case BT_PIC:
            return bridge->addr->pic_xxx;

        default:
            /* */
    }
}


