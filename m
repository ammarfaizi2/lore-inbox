Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbULQBdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbULQBdx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 20:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbULQBdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 20:33:53 -0500
Received: from coverity.dreamhost.com ([66.33.192.105]:64647 "EHLO
	coverity.dreamhost.com") by vger.kernel.org with ESMTP
	id S262713AbULQBdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 20:33:33 -0500
Subject: [Coverity] Untrusted user data in kernel
From: Bryan Fulton <bryan@coverity.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1103247211.3071.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 17:33:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, recently we ran a security checker over linux and discovered some 
flaws in the Linux 2.6.9 kernel. I've inserted into this post a few
examples of what we found.  These functions copy in user data
(copy_from_user) and use it as an array index, loop bound or memory
function argument without proper bounds checking.  

This posting just involves bugs in /fs, /net and /drivers/net. There
will be more postings for similar flaws in the drivers, as well as
network exploitable bugs and bugs in system calls.  

Some can be viewed as minor as they might involve directly passing an
unsigned tainted scalar to kmalloc. I was under the impression that
kmalloc has an implicit bounds check as it returns null if attempting to
allocate >64kb (or at least it used to). Can someone confirm/disconfirm
that? 

Suggestions for other security properties to check are welcome.  We
appreciate your feedback as a method to improve and expand our
security checkers.

Thanks,
.:Bryan Fulton and Ted Unangst of Coverity, Inc.

Quick location summary:

/fs/coda/pioctl.c::coda_pioctl
/fs/xfs/linux-2.6/xfs_ioctl.c::xfs_attrmulti_by_handle
/net/ipv6/netfilter/ip6_tables.c::do_replace
/net/bridge/br_ioctl.c::old_deviceless
/net/rose/rose_route.c::rose_rt_ioctl
/drivers/net/wan/sdla.c::sdla_xfer

/////////////////////////////////////////////////////
// 1:  /fs/coda/pioctl.c::coda_pioctl              //
/////////////////////////////////////////////////////
- tainted scalars (signed shorts) data->vi.in_size and data->vi.out_size
are used to copy memory from and to user space
- neither are properly upper/lower bounds checked (in_size only
upper-bound checked, out_size only lower-bound checked)

Call to function "copy_from_user" TAINTS argument "data"

61    if (copy_from_user(&data, (void __user *)user_data, sizeof(data)))
{
62        return -EINVAL;
63    }
64             

...

TAINTED variable "(data).vi" was passed to a tainted sink.

90    error = venus_pioctl(inode->i_sb, &(cnp->c_fid), cmd, &data);
91      
92    path_release(&nd);
93    return error;
94 }
95      
96      


inside linux-2.6.9/fs/coda/upcall.c::venus_pioctl

Checked upper bounds of signed scalar "((data)->vi).in_size" 
                                 by "((data)->vi).in_size > 8192"

553    if (data->vi.in_size > VC_MAXDATASIZE) {
554        error = -EINVAL;
555        goto exit;
556    }
557

...

Assigned TAINTED variable "((data)->vi).in_size" to variable
"((inp)->coda_ioctl).len"

568    inp->coda_ioctl.len = data->vi.in_size;

...

TAINTED variable "((data)->vi).in_size" passed to tainted data sink
"copy_from_user"

572    if ( copy_from_user((char*)inp + (long)inp->coda_ioctl.data,
573                         data->vi.in, data->vi.in_size) ) {
574            error = -EINVAL;
575            goto exit;
576    }

... 

Checked lower bounds of signed scalar "((data)->vi).out_size" by 
                            "((outp)->coda_ioctl).len >
((data)->vi).out_size"

588             if (outp->coda_ioctl.len > data->vi.out_size) {
589                     error = -EINVAL;
590             } else {

TAINTED variable "((data)->vi).out_size" passed to tainted data sink
"copy_to_user"

591                     if (copy_to_user(data->vi.out, 
592                                      (char *)outp +
(long)outp->coda_ioctl.data, 
593                                      data->vi.out_size)) {
594                             error = -EFAULT;
595                             goto exit;
596                     }



////////////////////////////////////////////////////////////////////
// 2:  /fs/xfs/linux-2.6/xfs_ioctl.c::xfs_attrmulti_by_handle     //
////////////////////////////////////////////////////////////////////

- tainted unsigned scalar am_hreq.opcount multiplied and passed to
kmalloc (512) and copy_from_user (518), and used as a loop bounds (524)
- this is fairly minor as there is a capable() call before the
copy_from_user in xfs_vget_fsop_handlereq

Call to function "xfs_vget_fsop_handlereq" TAINTS argument "am_hreq"

504    error = xfs_vget_fsop_handlereq(mp, parinode, CAP_SYS_ADMIN, arg,
505                                   
sizeof(xfs_fsop_attrmulti_handlereq_t),
506                                    (xfs_fsop_handlereq_t *)&am_hreq,
507                                    &vp, &inode);
508    if (error)
509           return -error;
510     

Assign TAINTED variable "((am_hreq).opcount * 24)" to variable "size"

511    size = am_hreq.opcount * sizeof(attr_multiop_t);

TAINTED variable "size" was passed to a tainted sink.

512    ops = (xfs_attr_multiop_t *)kmalloc(size, GFP_KERNEL);

...

TAINTED variable "size" was passed to a tainted sink.

518    if (copy_from_user(ops, am_hreq.ops, size)) {
519           kfree(ops);
520           VN_RELE(vp);
521           return -XFS_ERROR(EFAULT);
522    }
523 

TAINTED variable "(am_hreq).opcount" used as a loop boundary

524    for (i = 0; i < am_hreq.opcount; i++) {



////////////////////////////////////////////////////////
// 3:   /net/ipv6/netfilter/ip6_tables.c::do_replace  //
////////////////////////////////////////////////////////
 
- tainted unsigned scalar tmp.num_counters multiplied and passed to
vmalloc (1161) and memset (1166) which could overflow or be too large

Call to function "copy_from_user" TAINTS argument "tmp"

1143            if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)
1144                    return -EFAULT;

...

TAINTED variable "((tmp).num_counters * 16)" was passed to a tainted
sink.

1161            counters = vmalloc(tmp.num_counters * sizeof(struct
ip6t_counters));
1162            if (!counters) {
1163                    ret = -ENOMEM;
1164                    goto free_newinfo;
1165            }

TAINTED variable "((tmp).num_counters * 16)" was passed to a tainted
sink.

1166            memset(counters, 0, tmp.num_counters * sizeof(struct
ip6t_counters));



//////////////////////////////////////////////////
// 4:  /net/bridge/br_ioctl.c::old_deviceless   //
//////////////////////////////////////////////////

- tainted unsigned scalar args[2] multiplied and passed to kmalloc (327)
and memset (331) which could overflow
- same scalar then used as a boundary to array index to the alloc'd
memory (inside get_bridge_ifindices)

Call to function "copy_from_user" TAINTS argument "args"

315             if (copy_from_user(args, uarg, sizeof(args)))
316                     return -EFAULT;
317     
317     
318             switch (args[0]) {
319 

...

TAINTED variable "(args[2] * 4)" was passed to a tainted sink.

327                     indices = kmalloc(args[2]*sizeof(int),
GFP_KERNEL);

...

TAINTED variable "(args[2] * 4)" was passed to a tainted sink.

331                     memset(indices, 0, args[2]*sizeof(int));
332                     args[2] = get_bridge_ifindices(indices,
args[2]);
333     

inside /net/bridge/br_ioctl.c::get_bridge_ifindices

24      static int get_bridge_ifindices(int *indices, int num)
25      {
26              struct net_device *dev;
27              int i = 0;
28      
29              for (dev = dev_base; dev && i < num; dev = dev->next) {
30                      if (dev->priv_flags & IFF_EBRIDGE) 
31                              indices[i++] = dev->ifindex;
32              }
33      
34              return i;
35      }



////////////////////////////////////////////////// 
// 5:   /net/rose/rose_route.c::rose_rt_ioctl   //
//////////////////////////////////////////////////

- tainted scalar (unsigned char) rose_route->ndigis used as a loop
boundary (122) for indexing into rose_neigh->digipeat->calls[] of
8 structs

Call to function "copy_from_user" TAINTS argument "rose_route"

720                     if (copy_from_user(&rose_route, arg,
sizeof(struct
rose_route_struct)))
721                             return -EFAULT;

...mem.len

TAINTED variable "(rose_route).ndigis" was passed to a tainted sink.
[model]

731                     err = rose_add_node(&rose_route, dev);

inside /net/rose/rose_route.c::rose_add_node

112                     if (rose_route->ndigis != 0) {
...

Tainted variable "(rose_route)->ndigis" used as a loop boundary

122                             for (i = 0; i < rose_route->ndigis; i++)
{
123                                     rose_neigh->digipeat->calls[i]    =
124                                             rose_route->digipeaters[i];
125                                     rose_neigh->digipeat->repeated[i] = 0;
126                             }



//////////////////////////////////////////////
// 6:   /drivers/net/wan/sdla.c::sdla_xfer  //
//////////////////////////////////////////////

- tainted signed scalar mem.len passed to kmalloc and memset (1206 and
1211, or 1220 and 1223). Possibly minor because of kmalloc's
implicit size check

Call to function "copy_from_user" TAINTS argument "mem"

1201            if(copy_from_user(&mem, info, sizeof(mem)))

...

TAINTED variable "(mem).len" was passed to a tainted sink.

1206                    temp = kmalloc(mem.len, GFP_KERNEL);

...

TAINTED variable "(mem).len" was passed to a tainted sink.

1209                    memset(temp, 0, mem.len);
1210                    sdla_read(dev, mem.addr, temp, mem.len);

TAINTED variable "(mem).len" was passed to a tainted sink.

1211                    if(copy_to_user(mem.data, temp, mem.len))

...

TAINTED variable "(mem).len" was passed to a tainted sink.

1220                    temp = kmalloc(mem.len, GFP_KERNEL);
1221                    if (!temp)
1222                            return(-ENOMEM);

TAINTED variable "(mem).len" was passed to a tainted sink.

1223                    if(copy_from_user(temp, mem.data, mem.len))
1224                    {


-- 
Bryan J Fulton
Coverity, Inc.

Email: bryan@coverity.com


