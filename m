Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132860AbRDWQbE>; Mon, 23 Apr 2001 12:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132919AbRDWQaz>; Mon, 23 Apr 2001 12:30:55 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:46852 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S132801AbRDWQaj>;
	Mon, 23 Apr 2001 12:30:39 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Matt <madmatt@bits.bris.ac.uk>
Date: Mon, 23 Apr 2001 18:29:24 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: ioctl arg passing
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <EE31127966@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Apr 01 at 17:06, Matt wrote:
> struct instruction_t {
>     __s16 code;
>     __s16 rxlen;
>     __s16 *rxbuf;
>     __s16 txlen;
>     __s16 *txbuf;
> };

You should reorder fields, starting with largest fields and going down
to smaller ones. That ways you'll not have troubles with alignment when
someone decides to play with alignment rules...

> struct instruction_t local;
> __s16 *temp;
> 
> copy_from_user( &local, ( struct instruction_t * ) arg, sizeof( struct instruction_t ) );
> temp = kmalloc( sizeof( __s16 ) * local.rxlen, GFP_KERNEL );
> copy_from_user( temp, arg, sizeof( __s16 ) * local.rxlen );
> local.rxbuf = temp;
> temp = kmalloc( sizeof( __s16 ) * local.txlen, GFP_KERNEL );
> ...

As you are using signed value for rxlen/txlen, you should check
for value < 0 ... And there is very low chance that kmalloc() for 
anything bigger than 4KB will succeed. You should either use
vmalloc unconditionally, or at least as fallback. And some error
checking (copy_from_user returns 0 if everything went OK) also
makes driver safer.
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz

