Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267320AbSKSVnz>; Tue, 19 Nov 2002 16:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267344AbSKSVnz>; Tue, 19 Nov 2002 16:43:55 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:52864 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S267320AbSKSVnx>;
	Tue, 19 Nov 2002 16:43:53 -0500
Date: Tue, 19 Nov 2002 22:50:50 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Bob Miller <rem@osdl.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL PATCH 2.5.48] Fixed ifdefs for a label in ncpfs/sock.c
Message-ID: <20021119215050.GA4837@vana>
References: <20021119185236.GI1986@doc.pdx.osdl.net> <20021119190217.GA8317@suse.de> <20021119205823.GB4884@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119205823.GB4884@doc.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 12:58:23PM -0800, Bob Miller wrote:
> On Tue, Nov 19, 2002 at 07:02:17PM +0000, Dave Jones wrote:
> > On Tue, Nov 19, 2002 at 10:52:36AM -0800, Bob Miller wrote:
> >  > diff -Nru a/fs/ncpfs/sock.c b/fs/ncpfs/sock.c
> >  > --- a/fs/ncpfs/sock.c	Tue Nov 19 10:31:17 2002
> >  > +++ b/fs/ncpfs/sock.c	Tue Nov 19 10:31:17 2002
> >  > @@ -587,7 +587,9 @@
> >  >  				}
> >  >  #endif				
> >  >  				type = ntohs(server->rcv.buf.type);
> >  > +#ifdef CONFIG_NCPFS_PACKET_SIGNING				
> >  >  cont:;				
> >  > +#endif
> >  >  				if (type != NCP_REPLY) {
> >  >  					if (datalen - 8 <= sizeof(server->unexpected_packet.data)) {
> > 
> > Eww, personally I think the fix is worse than the warning.
> > 
> > 		Dave
> I know.  I personally hate #ifdef's and goto's...  I spent more than a few
> minutes trying to find a "trivial" way to clean this up, but this was
> the best I could do without reorganizing LOTS of code (then it's not
> "trivial" anymore).

If you want just eliminate some gotos (and eventually warnings... you should
always enable packet signing, btw), try this one ;-) But I'm not sure
that code below is better than using goto...
							Petr Vandrovec
							(ncpfs maintainer)

diff -u linux-2.5.48-c903.dist/fs/ncpfs/sock.c linux-2.5.48-c903/fs/ncpfs/sock.c
--- linux-2.5.48-c903.dist/fs/ncpfs/sock.c	2002-11-19 15:28:26.000000000 +0100
+++ linux-2.5.48-c903/fs/ncpfs/sock.c	2002-11-19 22:46:39.000000000 +0100
@@ -584,10 +584,12 @@
 					server->rcv.len = 8;
 					server->rcv.state = 4;
 					break;
-				}
+			case 4:
+					datalen = server->rcv.buf.len;
+					type = ntohs(server->rcv.buf.type2);
+				} else
 #endif				
 				type = ntohs(server->rcv.buf.type);
-cont:;				
 				if (type != NCP_REPLY) {
 					if (datalen - 8 <= sizeof(server->unexpected_packet.data)) {
 						*(__u16*)(server->unexpected_packet.data) = htons(type);
@@ -622,12 +624,6 @@
 				server->rcv.len = datalen - 10;
 				server->rcv.state = 1;
 				break;
-#ifdef CONFIG_NCPFS_PACKET_SIGNING				
-			case 4:
-				datalen = server->rcv.buf.len;
-				type = ntohs(server->rcv.buf.type2);
-				goto cont;
-#endif
 			case 1:
 				req = server->rcv.creq;
 				if (req->tx_type != NCP_ALLOC_SLOT_REQUEST) {
@@ -652,20 +648,20 @@
 				}
 #endif				
 				ncp_finish_request(req, req->datalen);
-			nextreq:;
+				if (0) {
+			case 3:
+					ncp_finish_request(server->rcv.creq, -EIO);
+				}
 				__ncp_next_request(server);
+				if (0) {
+			case 5:
+					info_server(server, 0, server->unexpected_packet.data, server->unexpected_packet.len);
+				}
 			case 2:
-			next:;
 				server->rcv.ptr = (unsigned char*)&server->rcv.buf;
 				server->rcv.len = 10;
 				server->rcv.state = 0;
 				break;
-			case 3:
-				ncp_finish_request(server->rcv.creq, -EIO);
-				goto nextreq;
-			case 5:
-				info_server(server, 0, server->unexpected_packet.data, server->unexpected_packet.len);
-				goto next;
 		}
 	}
 }
