Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318019AbSGWK0g>; Tue, 23 Jul 2002 06:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318020AbSGWK0f>; Tue, 23 Jul 2002 06:26:35 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:28427 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S318019AbSGWK0f>;
	Tue, 23 Jul 2002 06:26:35 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "David S. Miller" <davem@redhat.com>
Date: Tue, 23 Jul 2002 12:29:29 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] cli/sti in net/802/*
CC: linux-kernel@vger.kernel.org, acme@conectiva.com.br
X-mailer: Pegasus Mail v3.50
Message-ID: <BB58C644265@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jul 02 at 19:07, David S. Miller wrote:
> 
> These patches don't make any sense.
> 
> You aren't blocking against other things that cli/sti used
> to disable, namely timers and the generic input packet processing
> engine.
> 
> There is no way these changes are a correct replacement for cli/sti.
> This goes for your IPX changes too which I ask that you had pass
> through Arnaldo de Melo in the future as he has done a lot of work
> in this area.

Why? I'm definitely sure that IPX patches are correct: only
place which accesses spx_family_ops variable is ipx_create. 

If we have SPX sockets created when we call ipx_unregister_spx, we
have much worse problem, because of regardless of any cli/sti, we are
going to release af_spx memory very soon, and cli does not force us to
close all SPX sockets, does it?

As for p8022/psnap changes, yes, I missed datalink_header locking.
But because of IPX uses dl->datalink_header() happilly from process
context without any locking, I thought that users of proto structure
returned from register_* are responsible for making sure that they'll
not use it anymore when they call unregister_*. Adding (any) lock 
into *_datalink_header will not help unless you will call find_*_client 
in *_datalink_header after obtaining lock to revalidate pointer you 
received from caller. Which is obviously wrong, I'd say. And ipx
requires you to down all interfaces/close all sockets before it will 
call unregister_*_client, so IPX is safe here (at least as it was always;
if kernel can send packets to downed interface, it is completely another
problem).

Thanks for explanation,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
