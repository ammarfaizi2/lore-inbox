Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUAUAZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUAUAZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:25:45 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:12824 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261567AbUAUAZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:25:42 -0500
Message-ID: <400DC67C.30705@sgi.com>
Date: Tue, 20 Jan 2004 18:23:24 -0600
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: akpm@osdl.org, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix updates
References: <200401152154.i0FLscIG023452@fsgi900.americas.sgi.com> <20040116144132.A24555@infradead.org> <400D6A5B.7090009@sgi.com> <20040120180851.A18872@infradead.org> <400D8BBF.7070005@sgi.com> <20040120202132.A20668@infradead.org> <400DAA76.2080103@sgi.com> <20040120233417.A23173@infradead.org>
In-Reply-To: <20040120233417.A23173@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Tue, Jan 20, 2004 at 04:23:50PM -0600, Patrick Gefre wrote:
>  
>
>>I had one for bridge address/TIO, one for bridge address/nonTIO, one for 
>>soft address/TIO and one for soft address/nonTIO.
>>I thought that was what you were proposing. In any event, here's how the 
>>basic code looks (leaving out type defs/error checking/
>>etc) - the wrapper is embedded in the macro - note that we would always 
>>like to use the soft struct because it doesn't cost us a PIO
>>but in the event that the soft struct is not available the bridge 
>>address must be used:
>>    
>>
>
>(horrible piece of sh^H^H^code snipped)
>
>Eeek!
>
>So taking your pio cycle stuff into account, what about:
>
>void *
>__pcireg_xxx_get(bridge_t *bridge, int type)
>{
>     switch (type ) {
>        case BT_TIO:
>            return bridge_addr->ti_xxx;
>
>        case BT_PIC:
>            return bridge->addr->pic_xxx;
>
>        default:
>            /* */
>    }
>}
>
>and then have wrappers for both the plain bridge_t and the pcibr_soft.
>In fact I wonder why you want the one taking bridge_t at all, there is
>absolutely no reason why you should be able to get a bridge_t without
>getting at the pcibr_soft easily.
>  
>
>>void *
>>pcireg_xxx_get(void *ptr)
>>{
>>    if ( IS_IOADDR(ptr) )
>>        return REAL_pcireg_xxx_get(ptr, IS_TIO(ptr) ? BT_TIO : BT_PIC);
>>    else
>>        return REAL_pcireg_xxx_get(ptr->bs_base, ptr->bs_bridge_type);
>>       
>>}
>>    
>>
>
>No, this is borked again.  The IS_IOADDR tests must go away.
>
>  
>

So something like this will work for you ???

void *
pcireg_xxx_soft_get(ptr)
{
        return __pcireg_xxx_get(ptr->bs_base, ptr->bs_bridge_type);
}

void *
pcireg_xxx_get(ptr)
{
        return __pcireg_xxx_get(ptr, IS_TIO(ptr) ? BT_TIO : BT_PIC);
}

static void *
__pcireg_xxx_get(bridge_t *bridge, int type)
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



