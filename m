Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWJPAMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWJPAMU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 20:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWJPAMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 20:12:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36329 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751215AbWJPAMT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 20:12:19 -0400
Date: Mon, 16 Oct 2006 01:12:14 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linus Torvalds <torvalds@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] l2cap endianness annotations
Message-ID: <20061016001214.GA29920@ftp.linux.org.uk>
References: <20061015212905.GR29920@ftp.linux.org.uk> <1160955543.14340.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160955543.14340.21.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 01:39:03AM +0200, Marcel Holtmann wrote:
> > @@ -205,7 +205,7 @@ #define l2cap_pi(sk) ((struct l2cap_pinf
> >  
> >  struct l2cap_pinfo {
> >  	struct bt_sock	bt;
> > -	__u16		psm;
> > +	__le16		psm;
> >  	__u16		dcid;
> >  	__u16		scid;
> >  
> > @@ -221,7 +221,7 @@ struct l2cap_pinfo {
> >  
> >  	__u8		ident;
> >  
> > -	__u16		sport;
> > +	__le16		sport;
> >  
> >  	struct l2cap_conn	*conn;
> >  	struct sock		*next_c;
> 
> These are internal. We should have to annotate them. They should store
> it in host order. If not, than that is the problem.

BTW, I would leave ->psm is wire order; we compare it to ->l2_psm from
sockaddr_l2 a lot, so putting a conversion there looks odd.

Note that we do pass ->ls_psm to __l2cap_sock_by_addr(), so I'm not sure
if I like the idea of host-endian ->sport; we would need to slap a conversion
there as well.

See also
                bacpy(&bt_sk(sk)->src, &la->l2_bdaddr);
                l2cap_pi(sk)->psm   = la->l2_psm;
                l2cap_pi(sk)->sport = la->l2_psm;
                sk->sk_state = BT_BOUND;
for other place where net-endian gets there.

Are you sure that you want both to be switched to host-endian?
