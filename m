Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTJWVUj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 17:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTJWVUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 17:20:39 -0400
Received: from mail.skjellin.no ([80.239.42.67]:8602 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S261787AbTJWVUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 17:20:36 -0400
Subject: Re: Linux 2.4.23-pre8
From: Andre Tomt <andre@tomt.net>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031023181251.GA5490@titan.lahn.de>
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
	 <20031023181251.GA5490@titan.lahn.de>
Content-Type: text/plain
Message-Id: <1066944036.4293.103.camel@slurv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 23 Oct 2003 23:20:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-23 at 20:12, Philipp Matthias Hahn wrote:
> Hi Marcelo, Trond, LKML.
> 
> On Wed, Oct 22, 2003 at 09:24:17PM -0200, Marcelo Tosatti wrote:
> > Trond Myklebust:
> >   o Fix a deadlock in the NFS asynchronous write code
> >   o A request cannot be used as part of the RTO estimation if it gets
> >     resent since you don't know whether the server is replying to the 
> >     first or the second transmission. However we're currently setting the 
> >     cutoff point to be the timeout of the first transmission.
> >   o UDP round trip timer fix. Modify Karn's algorithm so that we inherit timeouts from previous requests.
> >   o Increase the minimum RTO timer value to 1/10 second. This is more in line with what is done for TCP.
> >   o Fix a stack overflow problem that was noticed by Jeff Garzik by removing some unused readdirplus cruft.
> >   o Make the client act correctly if the RPC server's asserts that it does not support a given program, version or procedure call.
> 
> make[3]: Entering directory `/usr/src/linux-2.4.23/net/sunrpc'
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.23/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -fno-optimize-sibling-calls -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=clnt  -c -o clnt.o clnt.c
> clnt.c: In function `call_verify':
> clnt.c:946: error: duplicate case value
> clnt.c:926: error: previously used here
> clnt.c:951: error: duplicate case value
> clnt.c:937: error: previously used here

Did you patch your source with ea+acl+nfsacl-2.4.22-0.8.63.diff.gz?
vanilla -pre8 looks fine, however a strikingly similar hunk is in the
ea+acl+nfsacl patch:


@@ -923,6 +925,16 @@ call_verify(struct rpc_task *task)
                return p;
        case RPC_GARBAGE_ARGS:
                break;                  /* retry */
+       case RPC_PROG_UNAVAIL:
+               /* report requested program number*/
+               dprintk(KERN_WARNING "RPC: unknown program\n");
+               rpc_exit(task, -ENOSYS);
+               return NULL;
+       case RPC_PROC_UNAVAIL:
+               /* report requested program and procedure number, version */
+               dprintk(KERN_WARNING "RPC: unknown procedure\n");
+               rpc_exit(task, -ENOSYS);
+               return NULL;
        default:
                printk(KERN_WARNING "call_verify: server accept status: %x\n", n);
                /* Also retry */

It looks safe to just nuke this hunk from the acl patch.

NB: Always test a clean kernel tree ;-)

-- 

