Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbWHAFWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbWHAFWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 01:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbWHAFWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 01:22:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43753 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161062AbWHAFWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 01:22:48 -0400
Subject: Re: [NFS] [PATCH 010 of 11] knfsd: make rpc threads pools numa
	aware
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060731214328.5770f1a5.akpm@osdl.org>
References: <20060731103458.29040.patches@notabene>
	 <1060731004234.29291@suse.de> <20060730211454.ccf803f3.akpm@osdl.org>
	 <17613.35001.745409.144623@cse.unsw.edu.au>
	 <1154320957.21040.1836.camel@hole.melbourne.sgi.com>
	 <1154325296.21040.1850.camel@hole.melbourne.sgi.com>
	 <20060731214328.5770f1a5.akpm@osdl.org>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1154409726.21040.2082.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 01 Aug 2006 15:22:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 14:43, Andrew Morton wrote:
> On Mon, 31 Jul 2006 15:54:57 +1000
> Greg Banks <gnb@melbourne.sgi.com> wrote:
> 
> > On Mon, 2006-07-31 at 14:42, Greg Banks wrote:
> > > On Mon, 2006-07-31 at 14:36, Neil Brown wrote:
> > > > On Sunday July 30, akpm@osdl.org wrote:
> > > > > On Mon, 31 Jul 2006 10:42:34 +1000
> > > > > NeilBrown <neilb@suse.de> wrote:
> > > > > 
> > > > > > +static int
> > > > > > +svc_pool_map_init_percpu(struct svc_pool_map *m)
> > > > > > +{
> > > > > > +	unsigned int maxpools = num_possible_cpus();
> > > > > > +	unsigned int pidx = 0;
> > > > > > +	unsigned int cpu;
> > > > > > +	int err;
> > > > > > +
> > > > > > +
> > > > > 
> > > > > That isn't right - it assumes that cpu_possible_map is not sparse.  If it
> > > > > is sparse, we allocate undersized pools and then overindex them.
> > > 
> > > Umm, I think Andrew's right, num_possible_cpus() should be NR_CPUS.
> > 
> > How about this version of the patch?  It replaces num_possible_cpus()
> > with highest_possible_processor_id()+1 and similarly for nodes.
> > --
> > 
> > knfsd: Actually implement multiple pools.  On NUMA machines, allocate
> > a svc_pool per NUMA node; on SMP a svc_pool per CPU; otherwise a single
> > global pool.  Enqueue sockets on the svc_pool corresponding to the CPU
> > on which the socket bh is run (i.e. the NIC interrupt CPU).  Threads
> > have their cpu mask set to limit them to the CPUs in the svc_pool that
> > owns them.
> > 
> > This is the patch that allows an Altix to scale NFS traffic linearly
> > beyond 4 CPUs and 4 NICs.
> > 
> > Incorporates changes and feedback from Neil Brown, Trond Myklebust,
> > Christoph Hellwig and Andrew Morton.
> > 
> 
> Something has gone rather wrong here.
> 
> > -	serv = __svc_create(prog, bufsize, shutdown, /*npools*/1);
> > +	serv = __svc_create(prog, bufsize, shutdown, npools);
> 
> __svc_create() is:
> 
> __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
> 	   void (*shutdown)(struct svc_serv *serv))
> 
> so heaven knows what tree you're patching.

Hmm.  Neil introduced the `shutdown' argument a few days ago, and I
thought I had his patches in my quilt tree, but apparently I screwed
something up.  Sorry about that.

> Incremental patches really are preferred.  So we can see what people are
> monkeying with ;)

Righto.

> After fixing the rejects and cleaning a few things up, your proposed change
> amounts to:
> 
> --- a/net/sunrpc/svc.c~knfsd-make-rpc-threads-pools-numa-aware-fix
> +++ a/net/sunrpc/svc.c
> @@ -116,7 +116,7 @@ fail:
>  static int
>  svc_pool_map_init_percpu(struct svc_pool_map *m)
>  {
> -	unsigned int maxpools = num_possible_cpus();
> +	unsigned int maxpools = highest_possible_processor_id() + 1;
>  	unsigned int pidx = 0;
>  	unsigned int cpu;
>  	int err;
> @@ -136,6 +136,18 @@ svc_pool_map_init_percpu(struct svc_pool
>  	return pidx;
>  };
>  
> +static int
> +highest_possible_node_id(void)
> +{
> +	unsigned int node;
> +	unsigned int highest = 0;
> +
> +	for_each_node(node)
> +		highest = node;
> +
> +	return highest;
> +}
> +
>  
>  /*
>   * Initialise the pool map for SVC_POOL_PERNODE mode.
> @@ -144,7 +156,7 @@ svc_pool_map_init_percpu(struct svc_pool
>  static int
>  svc_pool_map_init_pernode(struct svc_pool_map *m)
>  {
> -	unsigned int maxpools = num_possible_nodes();
> +	unsigned int maxpools = highest_possible_node_id() + 1;
>  	unsigned int pidx = 0;
>  	unsigned int node;
>  	int err;
> _
> 
> 

Yes.

> Which shouldn't have compiled, due to the missing forward declaration.

? It compiled, booted, and ran traffic.

gnb@chook 1965> quilt push 2
Applying patch knfsd-make-pools-numa-aware-5
patching file net/sunrpc/svc.c
patching file net/sunrpc/svcsock.c
patching file include/linux/sunrpc/svc.h
 
Applying patch knfsd-allow-admin-to-set-nthreads-per-node-2
patching file fs/nfsd/nfsctl.c
patching file fs/nfsd/nfssvc.c
 
Now at patch knfsd-allow-admin-to-set-nthreads-per-node-2

gnb@chook 1966> make  compressed modules
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  CC      arch/ia64/ia32/sys_ia32.o
  LD      arch/ia64/ia32/built-in.o
  CC      fs/compat.o
  CC      fs/nfsctl.o
  CC [M]  fs/lockd/clntlock.o
  CC [M]  fs/lockd/clntproc.o
  CC [M]  fs/lockd/host.o
  CC [M]  fs/lockd/svc.o
  CC [M]  fs/lockd/svclock.o
  CC [M]  fs/lockd/svcshare.o
  CC [M]  fs/lockd/svcproc.o
  CC [M]  fs/lockd/svcsubs.o
  CC [M]  fs/lockd/mon.o
  CC [M]  fs/lockd/xdr.o
  CC [M]  fs/lockd/xdr4.o
  CC [M]  fs/lockd/svc4proc.o
  LD [M]  fs/lockd/lockd.o
  CC [M]  fs/nfs/callback.o
  CC [M]  fs/nfs/callback_xdr.o
  LD [M]  fs/nfs/nfs.o
  CC [M]  fs/nfsd/nfssvc.o
  CC [M]  fs/nfsd/nfsctl.o
  CC [M]  fs/nfsd/nfsproc.o
  CC [M]  fs/nfsd/nfsfh.o
  CC [M]  fs/nfsd/vfs.o
  CC [M]  fs/nfsd/export.o
  CC [M]  fs/nfsd/auth.o
  CC [M]  fs/nfsd/lockd.o
  CC [M]  fs/nfsd/nfscache.o
  CC [M]  fs/nfsd/nfsxdr.o
  CC [M]  fs/nfsd/stats.o
  CC [M]  fs/nfsd/nfs2acl.o
  CC [M]  fs/nfsd/nfs3proc.o
  CC [M]  fs/nfsd/nfs3xdr.o
  CC [M]  fs/nfsd/nfs3acl.o
  CC [M]  fs/nfsd/nfs4proc.o
  CC [M]  fs/nfsd/nfs4xdr.o
  CC [M]  fs/nfsd/nfs4state.o
  CC [M]  fs/nfsd/nfs4idmap.o
  CC [M]  fs/nfsd/nfs4callback.o
  CC [M]  fs/nfsd/nfs4recover.o
  LD [M]  fs/nfsd/nfsd.o
  LD      fs/built-in.o
  CC [M]  net/sunrpc/svc.o
  CC [M]  net/sunrpc/svcsock.o
  CC [M]  net/sunrpc/svcauth.o
  CC [M]  net/sunrpc/svcauth_unix.o
  CC [M]  net/sunrpc/sunrpc_syms.o
  CC [M]  net/sunrpc/stats.o
  LD [M]  net/sunrpc/sunrpc.o
  CC [M]  net/sunrpc/auth_gss/auth_gss.o
  CC [M]  net/sunrpc/auth_gss/gss_mech_switch.o
  CC [M]  net/sunrpc/auth_gss/svcauth_gss.o
  CC [M]  net/sunrpc/auth_gss/gss_krb5_crypto.o
  CC [M]  net/sunrpc/auth_gss/gss_krb5_mech.o
  CC [M]  net/sunrpc/auth_gss/gss_krb5_seal.o
  CC [M]  net/sunrpc/auth_gss/gss_krb5_unseal.o
  CC [M]  net/sunrpc/auth_gss/gss_krb5_seqnum.o
  CC [M]  net/sunrpc/auth_gss/gss_krb5_wrap.o
  CC [M]  net/sunrpc/auth_gss/gss_spkm3_mech.o
  CC [M]  net/sunrpc/auth_gss/gss_spkm3_seal.o
  CC [M]  net/sunrpc/auth_gss/gss_spkm3_unseal.o
  CC [M]  net/sunrpc/auth_gss/gss_spkm3_token.o
  LD [M]  net/sunrpc/auth_gss/auth_rpcgss.o
  LD [M]  net/sunrpc/auth_gss/rpcsec_gss_krb5.o
  LD [M]  net/sunrpc/auth_gss/rpcsec_gss_spkm3.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
  SYSMAP System.map
  SYSMAP .tmp_System.map
  OBJCOPY arch/ia64/hp/sim/boot/vmlinux.bin
  GZIP    arch/ia64/hp/sim/boot/vmlinux.gz
  LN      vmlinux.gz
  Kernel: vmlinux.gz is ready
  Building modules, stage 2.
  MODPOST
WARNING: drivers/atm/fore_200e.o - Section mismatch: reference to .init.data:_fore200e_pca_fw_data from .data.rel.ro between 'fore200e_bus' (at offset 0x20) and 'fore200e_ops'
WARNING: drivers/atm/fore_200e.o - Section mismatch: reference to .init.data:_fore200e_pca_fw_size from .data.rel.ro between 'fore200e_bus' (at offset 0x28) and 'fore200e_ops'
WARNING: drivers/atm/fore_200e.o - Section mismatch: reference to .init.text:fore200e_pca_prom_read from .data.rel.ro between 'fore200e_bus' (at offset 0x90) and 'fore200e_ops'
WARNING: drivers/atm/he.o - Section mismatch: reference to .init.text:he_init_irq from .text between 'he_start' (at offset 0x2ca2) and 'he_irq_handler'
WARNING: drivers/atm/he.o - Section mismatch: reference to .init.text:he_init_cs_block_rcm from .text between 'he_start' (at offset 0x81c2) and 'he_irq_handler'WARNING: drivers/atm/he.o - Section mismatch: reference to .init.text: from .text between 'he_start' (at offset 0x81e2) and 'he_irq_handler'
WARNING: drivers/atm/he.o - Section mismatch: reference to .init.text:he_init_group from .text between 'he_start' (at offset 0x82a2) and 'he_irq_handler'
WARNING: drivers/block/cpqarray.o - Section mismatch: reference to .init.text:cpqarray_init_one from .data.rel.local between 'cpqarray_pci_driver' (at offset 0x20) and 'smart1_access'
WARNING: drivers/net/dgrs.o - Section mismatch: reference to .init.text:dgrs_pci_probe from .data.rel.local after 'dgrs_pci_driver' (at offset 0x20)
WARNING: drivers/net/tulip/de2104x.o - Section mismatch: reference to .init.text:de_init_one from .data.rel.local after 'de_driver' (at offset 0x20)
WARNING: drivers/net/tulip/de2104x.o - Section mismatch: reference to .exit.text:de_remove_one from .data.rel.local after 'de_driver' (at offset 0x28)
WARNING: drivers/usb/host/isp116x-hcd.o - Section mismatch: reference to .init.text:isp116x_probe from .data.rel.local between 'isp116x_driver' (at offset 0x0) and 'isp116x_hc_driver'
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to .init.text:aty_get_pll_ct from .data.rel.ro after 'aty_pll_ct' (at offset 0x18)
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to .init.text:aty_init_pll_ct from .data.rel.ro after 'aty_pll_ct' (at offset 0x20)
WARNING: drivers/video/nvidia/nvidiafb.o - Section mismatch: reference to .exit.text:nvidiafb_remove from .data.rel.local after 'nvidiafb_driver' (at offset 0x28)
WARNING: drivers/video/riva/rivafb.o - Section mismatch: reference to .exit.text:rivafb_remove from .data.rel.local after 'rivafb_driver' (at offset 0x28)
WARNING: sound/drivers/snd-dummy.o - Section mismatch: reference to .init.text:snd_dummy_probe from .data.rel.local between 'snd_dummy_driver' (at offset 0x0) and 'snd_dummy_controls'
WARNING: sound/drivers/snd-mtpav.o - Section mismatch: reference to .init.text:snd_mtpav_probe from .data.rel.local between 'snd_mtpav_driver' (at offset 0x0) and 'snd_mtpav_input'
WARNING: sound/drivers/snd-serial-u16550.o - Section mismatch: reference to .init.text:snd_serial_probe from .data.rel.local between 'snd_serial_driver' (at offset 0x0) and 'ops.15504'
WARNING: sound/drivers/snd-virmidi.o - Section mismatch: reference to .init.text:snd_virmidi_probe from .data.rel.local after 'snd_virmidi_driver' (at offset 0x0)
  LD [M]  fs/lockd/lockd.ko
  LD [M]  fs/nfs/nfs.ko
  LD [M]  fs/nfsd/nfsd.ko
  LD [M]  net/sunrpc/auth_gss/auth_rpcgss.ko
  LD [M]  net/sunrpc/auth_gss/rpcsec_gss_krb5.ko
  LD [M]  net/sunrpc/auth_gss/rpcsec_gss_spkm3.ko
  CC      net/sunrpc/sunrpc.mod.o
  LD [M]  net/sunrpc/sunrpc.ko


gnb@chook 1967> gcc --version
gcc (GCC) 4.1.0 (SUSE Linux)
Copyright (C) 2006 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

>   And
> I'd be surprised if it worked very well with CONFIG_NUMA=n.

Why?  The only new code which is sensitive to CONFIG_NUMA is
for_each_node(node) and that has a definition for !NUMA that
appears (by inspection) to do the right thing.

>   And it's
> naughty to be sneaking general library functions into the sunrpc code
> anyway.

Fair enough, my bad.

> 
> Please,
> 
> - Write a standalone patch which adds highest_possible_node_id() to
>   lib/cpumask.c(?)
> 
>   Make sure it's inside #ifdef CONFIG_NUMA
> 
>   Remember to export it to modules.
> 
>   Provide a !CONFIG_NUMA version in include/linux/nodemask.h which just
>   returns constant zero.

Will do.

>   Consider doing something more efficient than the for_each_node() loop. 
>   Although I'm not sure what that would be, given that we don't have
>   find_last_bit().

That code is a copy-n-paste of highest_possible_processor_id().

> - Provide an incremental patch against
>   knfsd-make-rpc-threads-pools-numa-aware.patch which utilises
>   highest_possible_node_id().
> 
>   A replacement patch will be grudgingly accepted, but I'll only go and
>   turn it into an incremental one, so you can't hide ;)

Ok, an incremental patch it is then.  Let it not be said I
don't take a hint the fourth time.

> - Test it real good.  Modular, non-modular, NUMA, non-NUMA, !SMP.
> 

Right.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


