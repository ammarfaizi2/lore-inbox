Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422924AbWJOXtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422924AbWJOXtI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 19:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422930AbWJOXtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 19:49:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:2966 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422924AbWJOXtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 19:49:07 -0400
Date: Mon, 16 Oct 2006 00:49:02 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linus Torvalds <torvalds@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] l2cap endianness annotations
Message-ID: <20061015234902.GY29920@ftp.linux.org.uk>
References: <20061015212905.GR29920@ftp.linux.org.uk> <1160955543.14340.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160955543.14340.21.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 01:39:03AM +0200, Marcel Holtmann wrote:
> this data structure is visible to the userspace (via the Bluetooth
> library headers). Do we annotate them, too?

Yes. linux/types.h is exported header and it defines all endian types.
 
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

They do not.  Trivial search in vanilla tree shows
                for (psm = 0x1001; psm < 0x1100; psm += 2)
                        if (!__l2cap_get_sock_by_addr(psm, src)) {
                                l2cap_pi(sk)->psm   = htobs(psm);
                                l2cap_pi(sk)->sport = htobs(psm);
                                err = 0;
                                break;
                        }

which is very definitely not putting a host-endian there.  You can
switch it to host-endian, of course, but then you have to modify
at least that place.
 
> > @@ -1533,7 +1533,7 @@ static inline int l2cap_config_req(struc
> >  	if (!(sk = l2cap_get_chan_by_scid(&conn->chan_list, dcid)))
> >  		return -ENOENT;
> >  
> > -	l2cap_parse_conf_req(sk, req->data, cmd->len - sizeof(*req));
> > +	l2cap_parse_conf_req(sk, req->data, __le16_to_cpu(cmd->len) - sizeof(*req));
> 
> I have to look into this change. It basically means that this code never
> worked on big endian systems, but it actually does.

You are misreading it.  Old code flipped cmd->len in place in the caller.
New one doesn't.
