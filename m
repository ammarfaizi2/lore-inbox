Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266172AbUF3HE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266172AbUF3HE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 03:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUF3HE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 03:04:58 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:27560 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S266172AbUF3HEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 03:04:43 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: <bvaughan@mindspring.com>, <linux-kernel@vger.kernel.org>
Date: Wed, 30 Jun 2004 17:04:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16610.26113.391281.310588@cse.unsw.edu.au>
Subject: Re: PROBLEM: Oops, nfsd, networking 
In-Reply-To: message from Neil Brown on Tuesday June 29
References: <S264922AbUF1MSP/20040628121815Z+10@vger.kernel.org>
	<16608.45673.307911.340194@cse.unsw.edu.au>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday June 29, neilb@cse.unsw.edu.au wrote:
> On Monday June 28, bvaughan@mindspring.com wrote:
> > NFSD crash at large MTU and odd wsize/rsize.
> >  
> 
....
> 
> Would you be able to change that code to:
> 	while (len > args->vec[v].iov_len) {
> 		len -= args->vec[v].iov_len;
> 		v++;
> 		if (rqstp->rq_argpages[v] == NULL) {
> 			printk("NULL page at %d, c=%d al=%d l=%d pl=%d\n",
> 				v, args->count, args->len, len,	rqstp->rq_arg.len);
> 		        BUG();
> 		}
> 		args->vec[v].iov_base = page_address(rqstp->rq_argpages[v]);
> 		args->vec[v].iov_len = PAGE_SIZE;
> 	}
> 
> (i.e. add the if() { printk..} bit).
> and tell me what gets printed out?

To which Bill Vaughan replied:

  Jun 29 12:20:09 localhost kernel: NULL page at 11, c=0 al=-802973147 l=-803029103 pl=15084


Ok, that makes it easy, thanks.  'len' should be unsigned, and when we
do
	if (len > NFSSVC_MAXBLKSIZE)
		len = NFSSVC_MAXBLKSIZE;
a very large, and hence negative, 'len' doesn't get corrected :-(

So the following patch should fix the BUG, but it doesn't explain why
'len' is such a large number.  The request must be getting corrupted
somewhere between the NFS client and the NFS server, possibly
somewhere in the network stack of one or the other.

Is there any chance of capturing a network trace (tcpdump -s 1000)
when this problem occurs so we can see if there are any bad packets
coming from the client, or if the packet is getting corrupted in the
server?

Thanks,
NeilBrown


### Diffstat output
 ./fs/nfsd/nfs3xdr.c |   16 +++++++++++-----
 ./fs/nfsd/nfsxdr.c  |    4 ++--
 2 files changed, 13 insertions(+), 7 deletions(-)

diff ./fs/nfsd/nfs3xdr.c~current~ ./fs/nfsd/nfs3xdr.c
--- ./fs/nfsd/nfs3xdr.c~current~	2004-06-30 11:01:59.000000000 +1000
+++ ./fs/nfsd/nfs3xdr.c	2004-06-30 11:14:01.000000000 +1000
@@ -74,7 +74,7 @@ decode_fh(u32 *p, struct svc_fh *fhp)
 static inline u32 *
 encode_fh(u32 *p, struct svc_fh *fhp)
 {
-	int size = fhp->fh_handle.fh_size;
+	unsigned int size = fhp->fh_handle.fh_size;
 	*p++ = htonl(size);
 	if (size) p[XDR_QUADLEN(size)-1]=0;
 	memcpy(p, &fhp->fh_handle.fh_base, size);
@@ -328,7 +328,7 @@ int
 nfs3svc_decode_readargs(struct svc_rqst *rqstp, u32 *p,
 					struct nfsd3_readargs *args)
 {
-	int len;
+	unsigned int len;
 	int v,pn;
 
 	if (!(p = decode_fh(p, &args->fh))
@@ -358,7 +358,7 @@ int
 nfs3svc_decode_writeargs(struct svc_rqst *rqstp, u32 *p,
 					struct nfsd3_writeargs *args)
 {
-	int len, v;
+	unsigned int len, v;
 
 	if (!(p = decode_fh(p, &args->fh))
 	 || !(p = xdr_decode_hyper(p, &args->offset)))
@@ -368,6 +368,12 @@ nfs3svc_decode_writeargs(struct svc_rqst
 	args->stable = ntohl(*p++);
 	len = args->len = ntohl(*p++);
 
+	if (rqstp->rq_arg.len <
+	    len + ( (char*)p -
+		    (char*)rqstp->rq_arg.head[0].iov_base)) {
+		return 0;
+	}
+
 	args->vec[0].iov_base = (void*)p;
 	args->vec[0].iov_len = rqstp->rq_arg.head[0].iov_len -
 		(((void*)p) - rqstp->rq_arg.head[0].iov_base);
@@ -427,7 +433,7 @@ int
 nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, u32 *p,
 					struct nfsd3_symlinkargs *args)
 {
-	int len;
+	unsigned int len;
 	int avail;
 	char *old, *new;
 	struct iovec *vec;
@@ -444,7 +450,7 @@ nfs3svc_decode_symlinkargs(struct svc_rq
 	 */
 	svc_take_page(rqstp);
 	len = ntohl(*p++);
-	if (len <= 0 || len > NFS3_MAXPATHLEN || len >= PAGE_SIZE)
+	if (len == 0 || len > NFS3_MAXPATHLEN || len >= PAGE_SIZE)
 		return 0;
 	args->tname = new = page_address(rqstp->rq_respages[rqstp->rq_resused-1]);
 	args->tlen = len;

diff ./fs/nfsd/nfsxdr.c~current~ ./fs/nfsd/nfsxdr.c
--- ./fs/nfsd/nfsxdr.c~current~	2004-06-30 11:14:16.000000000 +1000
+++ ./fs/nfsd/nfsxdr.c	2004-06-30 11:14:30.000000000 +1000
@@ -234,7 +234,7 @@ int
 nfssvc_decode_readargs(struct svc_rqst *rqstp, u32 *p,
 					struct nfsd_readargs *args)
 {
-	int len;
+	unsigned int len;
 	int v,pn;
 	if (!(p = decode_fh(p, &args->fh)))
 		return 0;
@@ -266,7 +266,7 @@ int
 nfssvc_decode_writeargs(struct svc_rqst *rqstp, u32 *p,
 					struct nfsd_writeargs *args)
 {
-	int len;
+	unsigned int len;
 	int v;
 	if (!(p = decode_fh(p, &args->fh)))
 		return 0;

