Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265908AbUEUP1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265908AbUEUP1U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 11:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUEUP1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 11:27:20 -0400
Received: from mail.zrz.TU-Berlin.DE ([130.149.4.15]:12191 "EHLO
	mail.zrz.tu-berlin.de") by vger.kernel.org with ESMTP
	id S265908AbUEUP1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 11:27:17 -0400
From: Andreas Amann <amann@physik.tu-berlin.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.6 breaks kmail (nfs related?)
Date: Fri, 21 May 2004 17:27:14 +0200
User-Agent: KMail/1.6.2
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200405131411.52336.amann@physik.tu-berlin.de> <200405171331.35688.amann@physik.tu-berlin.de> <1084809309.3669.17.camel@lade.trondhjem.org>
In-Reply-To: <1084809309.3669.17.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200405211727.14917.amann@physik.tu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 May 2004 17:55, Trond Myklebust wrote:
> På må , 17/05/2004 klokka 07:31, skreiv Andreas Amann:
> > fstat64(8, 0xbfffe650)                  = -1 ESTALE (Stale NFS file
> > handle) _llseek(8, 0, [373], SEEK_END)          = 0
> > write(8, "X\1\0\0", 4)                  = -1 ESTALE (Stale NFS file
> > handle) write(8,
> > "\5\0\0\0,\0\0a\0z\0/\0w\0t\0z\0t\0+\0N\0S\0+\0001\0s"..., 344) = -1
> > ESTALE (Stale NFS file handle)
>
> That's wierd... Where could that be coming from? The client is *never*
> supposed to generate that on its own. If an ESTALE turns up, it should
> always be generated from the server.
>
> Does that same ESTALE show up on a tcpdump/ethereal dump? If so, could
> you please check that the filehandle that is contained from the reply to
> LOOKUP(".outbox.index") is the same as that which is sent on the
> offending GETATTR call?

I now produced the "etheral" dumps and put them on:
http://wwwnlds.physik.tu-berlin.de/~amann/kmail_bug/kmail_etheral_cut_2.6.4 
http://wwwnlds.physik.tu-berlin.de/~amann/kmail_bug/kmail_etheral_cut_2.6.6

together with the pertinent  "strace"s at:
http://wwwnlds.physik.tu-berlin.de/~amann/kmail_bug/kmail_trace_2.6.4_new
http://wwwnlds.physik.tu-berlin.de/~amann/kmail_bug/kmail_trace_2.6.6_new

I interpret the dump in the failing case with the 2.6.6 client as follows:
First the Filehandle for ".outbox.index" (0xdc36f60a) is delivered by a  
READDIRPLUS Reply (Frame 4 in  kmail_etheral_cut_2.6.6). Then the client does  
GETATTR, ACCESS, SETATTR, READ (Frames 100-114) without any problems. 
The client subsequnetly issues a WRITE and a COMMIT (Frame 741 + 751) command, 
which are still successful. But the immediadetly following GETATTR (Frame 
743) fails with ERR_STALE. 

In the case where the client is 2.6.4, the dumps look very similar, except 
that now a lot of the GETATTR Calls are missing. In particular the GETATTR 
which failed in the 2.6.6 case is not present, and therefore can not fail. 

In both cases the server was 2.4.25. Who is now wrong in this case, the client 
or the server? To me it looks now, as if the server needs to be fixed, but I 
am no expert. 


Andreas



