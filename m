Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317677AbSFRXum>; Tue, 18 Jun 2002 19:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317678AbSFRXul>; Tue, 18 Jun 2002 19:50:41 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:52437 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S317677AbSFRXuk>; Tue, 18 Jun 2002 19:50:40 -0400
Message-ID: <3D0FC3A8.7030101@drugphish.ch>
Date: Wed, 19 Jun 2002 01:35:04 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS (vfs-related) syscall logging
References: <3D0A5E64.3020705@drugphish.ch> <shsadpv7y3y.fsf@charged.uio.no> <3D0E10BA.3010604@drugphish.ch> <200206171913.53561.trond.myklebust@fys.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> 'ethereal' *is* a damned intelligent parser that understands RPC/NFS/... ;-)
                     ^^^^^^
                       :)

Yes, it does, but it is a pain to get for example nfsd_unlink or 
nfsd_create_v3 calls and filter out the UID, GID and pathname. And 
fiddling around with nfs.data is quite a pain too. Plus (t)ethereal 
opens yet another code path in the TCP/IP stack via skb_clone() to add 
it to the ptype_all list while running. I'd like to do things where they 
should be done ;).

> You should be able to use its read filtering capabilities to cherry-pick 
> exactly the information that interests you.

I tried for a while but I found it easier to extend the current NFS code 
  with my needs, especially after you gave me the hint below!

> If you are going to insist on logging using printks, you might as well just 
> use the existing RPC debugging code. Just rewrite your printks to the format
> 
> dfprintk(BITMASK, format,...)
> 
> The value of BITMASK can be whatever you want, although the masks between 
> 0x0001 and 0x0200 are already used by the existing nfsd debugging code (see 
> include/linux/nfsd/debug.h).
> 
> Then just 'echo BITMASK >/proc/sys/sunrpc/nfsd_debug' in order to begin 
> logging.

Thank you very much for this valuable hint. Since I'm using a recursive 
function in my patch to print the pathname along with the according 
syscall it turned out to be stupid to use dfprintk for the first part of 
the output and then trying to patch together the rest. What I did was 
following (basic chunk of code responsible for a syscall):

+ 
if (nfsd_debug & NFSDDBG_SYSREAD){
+ 
	printk(KERN_INFO "NFSLOG UID=%d GID=%d FILE=",
+ 
		rqstp->rq_cred.cr_uid,
+ 
		rqstp->rq_cred.cr_gid);
+ 
	print_dirname(fhp->fh_dentry);
+ 
	printk(" OP=%s IP=%d.%d.%d.%d\n",
+ 
		__FUNCTION__,
+ 
		NIPQUAD(rqstp->rq_addr.sin_addr.s_addr));

I enhanced the debug.h with 5 new bitmasks (no more left now) and use 
them like that, despite the fact that dfprintk would add the NFSDDBG_ 
part. print_dirname now can be kept simple:

+static void print_dirname(struct dentry *getdentry) {
+ 
if ((getdentry != NULL) && !IS_ROOT(getdentry)){
+ 
	print_dirname(getdentry->d_parent);
+ 
}
+ 
if (!IS_ROOT(getdentry)) {
+ 
	printk("/%s", getdentry->d_name.name);
+ 
}
+}

Now another interesting thing I found was that the fname in nfsd_unlink 
is not always passed up correctly. I haven't tracked it down to the 
exact byte but you can reproduce it like follows:

1. mount a NFS export
2. create a deeply nested directory tree with let's say 30 Bytes as a
    pathname
3. now do a: echo "test" > test && rm -f ./test
4. watch the output of fname in unlink via a well placed printk().
5. fname must have length 4 and the tree must have a certain length too,
    I haven't found that one out yet

fname is already passed over in a wrong way at ../fs/nfsd/nfs3proc.c in 
nfsd3_proc_remove(). In my case with a printk("fname=%s", fname) I get
fname=test^A for nfsd_unlink and fname=test for nfsd_create_v3. Could 
you have a look into that one, please?

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

