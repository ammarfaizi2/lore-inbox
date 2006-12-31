Return-Path: <linux-kernel-owner+w=401wt.eu-S933184AbWLaPQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933184AbWLaPQZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 10:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933188AbWLaPQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 10:16:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50084 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933184AbWLaPQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 10:16:24 -0500
Subject: Re: kref refcnt and false positives
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linuxppc-dev@ozlabs.org
In-Reply-To: <200612210901.kBL91MwR027509@hera.kernel.org>
References: <200612210901.kBL91MwR027509@hera.kernel.org>
Content-Type: text/plain
Date: Sun, 31 Dec 2006 15:16:18 +0000
Message-Id: <1167578178.22068.326.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-21 at 09:01 +0000, Linux Kernel Mailing List wrote:
> Gitweb:     http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f334b60b43a0927f4ab1187cbdb4582f5227c3b1
> Commit:     f334b60b43a0927f4ab1187cbdb4582f5227c3b1
> Parent:     f238085415c56618e042252894f2fcc971add645
> Author:     Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> AuthorDate: Tue Dec 19 13:01:29 2006 -0800
> Committer:  Greg Kroah-Hartman <gregkh@suse.de>
> CommitDate: Wed Dec 20 10:56:43 2006 -0800
> 
>     kref refcnt and false positives
>     
>     With WARN_ON addition to kobject_init()
>     [ http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19/2.6.19-mm1/dont-use/broken-out/gregkh-driver-kobject-warn.patch ]
>     
>     I started seeing following WARNING on CPU offline followed by online on my
>     x86_64 system.
>     
>     WARNING at lib/kobject.c:172 kobject_init()
>     
 <...>
>     This is a false positive as mce.c is unregistering/registering sysfs
>     interfaces cleanly on hotplug.
>     
>     kref_put() and conditional decrement of refcnt seems to be the root cause
>     for this and the patch below resolves the issue for me.
>     
>     Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
>  lib/kref.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/kref.c b/lib/kref.c
> index 4a467fa..0d07cc3 100644
> --- a/lib/kref.c
> +++ b/lib/kref.c
> @@ -52,12 +52,7 @@ int kref_put(struct kref *kref, void (*release)(struct kref *kref))
>  	WARN_ON(release == NULL);
>  	WARN_ON(release == (void (*)(struct kref *))kfree);
>  
> -	/*
> -	 * if current count is one, we are the last user and can release object
> -	 * right now, avoiding an atomic operation on 'refcount'
> -	 */
> -	if ((atomic_read(&kref->refcount) == 1) ||
> -	    (atomic_dec_and_test(&kref->refcount))) {
> +	if (atomic_dec_and_test(&kref->refcount)) {
>  		release(kref);
>  		return 1;
>  	}

This makes my Maple board very unhappy -- it triggers a WARN_ON() in
kref_get() lots of times...

time_init: decrementer frequency = 175.000000 MHz                               
time_init: processor frequency   = 1400.000000 MHz                              
------------[ cut here ]------------                                            
Badness at lib/kref.c:32                                                        
Call Trace:                                                                     
[C00000000050F440] [C00000000000F4C8] .show_stack+0x68/0x1b0 (unreliable)       
[C00000000050F4E0] [C000000000189708] .report_bug+0x94/0xe8                     
[C00000000050F570] [C000000000021A98] .program_check_exception+0x18c/0x5d0      
[C00000000050F640] [C000000000004774] program_check_common+0xf4/0x100           
--- Exception: 700 at .kref_get+0xc/0x24                                        
    LR = .of_node_get+0x20/0x3c                                                 
[C00000000050F930] [C00000000050F9D0] init_thread_union+0x39d0/0x4000 (unreliabl
e)                                                                              
[C00000000050F9B0] [C000000000020F1C] .of_get_parent+0x38/0x64                  
[C00000000050FA40] [C00000000001B750] .of_translate_address+0xf0/0x38c          
[C00000000050FB50] [C00000000001BA28] .__of_address_to_resource+0x3c/0xe0       
[C00000000050FBF0] [C00000000001BB14] .of_address_to_resource+0x48/0x68         
[C00000000050FC90] [C00000000045D240] .maple_get_boot_time+0x40/0x12c           
[C00000000050FD70] [C00000000001F884] .get_boot_time+0x3c/0xb8                  
[C00000000050FE10] [C000000000454040] .time_init+0x274/0x450                    
[C00000000050FEF0] [C00000000044B74C] .start_kernel+0x188/0x2bc                 
[C00000000050FF90] [C0000000000084C8] .start_here_common+0x54/0x8c              
Maple: Found RTC at IO 0x900                                                    
Console: colour dummy device 80x25                                              
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)                 
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)                  
Memory: 501628k/524288k available (4608k kernel code, 21932k reserved, 552k data
, 354k bss, 212k init)                                                          
Calibrating delay loop... 349.18 BogoMIPS (lpj=698368)                          
Mount-cache hash table entries: 256                                             
------------[ cut here ]------------                                            
Badness at lib/kref.c:32                                                        
Call Trace:                                                                     
[C00000000050F7F0] [C00000000000F4C8] .show_stack+0x68/0x1b0 (unreliable)       
[C00000000050F890] [C000000000189708] .report_bug+0x94/0xe8                     
[C00000000050F920] [C000000000021A98] .program_check_exception+0x18c/0x5d0      
[C00000000050F9F0] [C000000000004774] program_check_common+0xf4/0x100           
--- Exception: 700 at .kref_get+0xc/0x24                                        
    LR = .of_node_get+0x20/0x3c                                                 
[C00000000050FCE0] [C00000001F7DDF38] 0xc00000001f7ddf38 (unreliable)           
[C00000000050FD60] [C000000000020650] .of_find_node_by_path+0x60/0xac           
[C00000000050FDE0] [C0000000000EE038] .proc_device_tree_init+0x58/0xa4          
[C00000000050FE70] [C0000000004641AC] .proc_root_init+0x134/0x168               
[C00000000050FEF0] [C00000000044B860] .start_kernel+0x29c/0x2bc                 
[C00000000050FF90] [C0000000000084C8] .start_here_common+0x54/0x8c              
mpic: requesting IPIs ...                                                       
Processor 1 is stuck.                                                           
Brought up 1 CPUs                                                               
NET: Registered protocol family 16                                              
PCI: Probing PCI hardware                                                       
Failed to request PCI IO region on PCI domain 0000                              
------------[ cut here ]------------                                            
Badness at lib/kref.c:32                                                        
Call Trace:                                                                     
[C00000001F7832E0] [C00000000000F4C8] .show_stack+0x68/0x1b0 (unreliable)       
[C00000001F783380] [C000000000189708] .report_bug+0x94/0xe8                     
[C00000001F783410] [C000000000021A98] .program_check_exception+0x18c/0x5d0      
[C00000001F7834E0] [C000000000004774] program_check_common+0xf4/0x100           
--- Exception: 700 at .kref_get+0xc/0x24                                        
    LR = .of_node_get+0x20/0x3c                                                 
[C00000001F7837D0] [C00000001F783870] 0xc00000001f783870 (unreliable)           
[C00000001F783850] [C000000000020F1C] .of_get_parent+0x38/0x64                  
[C00000001F7838E0] [C00000000001ACE4] .of_irq_map_raw+0x100/0x4cc               
[C00000001F7839E0] [C00000000001B190] .of_irq_map_one+0xe0/0x11c                
[C00000001F783A90] [C00000000001BFB4] .of_irq_map_pci+0x74/0x1b8                
[C00000001F783B40] [C0000000000271EC] .pci_read_irq_line+0x20/0x100             
[C00000001F783BF0] [C00000000002741C] .do_bus_setup+0x94/0x108                  
[C00000001F783C80] [C000000000027538] .pcibios_fixup_bus+0xa8/0x11c             
[C00000001F783D00] [C000000000196620] .pci_scan_child_bus+0x64/0x100            
[C00000001F783DA0] [C000000000028388] .scan_phb+0x1a0/0x1d8                     
[C00000001F783E40] [C00000000045A190] .pcibios_init+0x4c/0x18c                  
[C00000001F783EC0] [C0000000000093AC] .init+0x1bc/0x394                         
[C00000001F783F90] [C000000000023364] .kernel_thread+0x4c/0x68                  
------------[ cut here ]------------                                            
Badness at lib/kref.c:32                                                        
Call Trace:                                                                     
[C00000001F7832E0] [C00000000000F4C8] .show_stack+0x68/0x1b0 (unreliable)       
[C00000001F783380] [C000000000189708] .report_bug+0x94/0xe8                     
[C00000001F783410] [C000000000021A98] .program_check_exception+0x18c/0x5d0      
[C00000001F7834E0] [C000000000004774] program_check_common+0xf4/0x100           
--- Exception: 700 at .kref_get+0xc/0x24                                        
    LR = .of_node_get+0x20/0x3c                                                 
[C00000001F7837D0] [C00000001F783870] 0xc00000001f783870 (unreliable)           
[C00000001F783850] [C000000000020F1C] .of_get_parent+0x38/0x64                  
[C00000001F7838E0] [C00000000001ACE4] .of_irq_map_raw+0x100/0x4cc               
[C00000001F7839E0] [C00000000001B190] .of_irq_map_one+0xe0/0x11c                
[C00000001F783A90] [C00000000001BFB4] .of_irq_map_pci+0x74/0x1b8                
[C00000001F783B40] [C0000000000271EC] .pci_read_irq_line+0x20/0x100             
[C00000001F783BF0] [C00000000002741C] .do_bus_setup+0x94/0x108                  
[C00000001F783C80] [C000000000027538] .pcibios_fixup_bus+0xa8/0x11c             
[C00000001F783D00] [C000000000196620] .pci_scan_child_bus+0x64/0x100            
[C00000001F783DA0] [C000000000028388] .scan_phb+0x1a0/0x1d8                     
[C00000001F783E40] [C00000000045A190] .pcibios_init+0x4c/0x18c                  
[C00000001F783EC0] [C0000000000093AC] .init+0x1bc/0x394                         
[C00000001F783F90] [C000000000023364] .kernel_thread+0x4c/0x68                  
------------[ cut here ]------------                                            
Badness at lib/kref.c:32                                                        
Call Trace:                                                                     
[C00000001F7832E0] [C00000000000F4C8] .show_stack+0x68/0x1b0 (unreliable)       
[C00000001F783380] [C000000000189708] .report_bug+0x94/0xe8                     
[C00000001F783410] [C000000000021A98] .program_check_exception+0x18c/0x5d0      
[C00000001F7834E0] [C000000000004774] program_check_common+0xf4/0x100           
--- Exception: 700 at .kref_get+0xc/0x24                                        
    LR = .of_node_get+0x20/0x3c                                                 
[C00000001F7837D0] [C00000001F783870] 0xc00000001f783870 (unreliable)           
[C00000001F783850] [C000000000020F1C] .of_get_parent+0x38/0x64                  
[C00000001F7838E0] [C00000000001ACE4] .of_irq_map_raw+0x100/0x4cc               
[C00000001F7839E0] [C00000000001B190] .of_irq_map_one+0xe0/0x11c                
[C00000001F783A90] [C00000000001BFB4] .of_irq_map_pci+0x74/0x1b8                
[C00000001F783B40] [C0000000000271EC] .pci_read_irq_line+0x20/0x100             
[C00000001F783BF0] [C00000000002741C] .do_bus_setup+0x94/0x108                  
[C00000001F783C80] [C000000000027538] .pcibios_fixup_bus+0xa8/0x11c             
[C00000001F783D00] [C000000000196620] .pci_scan_child_bus+0x64/0x100            
[C00000001F783DA0] [C000000000028388] .scan_phb+0x1a0/0x1d8                     
[C00000001F783E40] [C00000000045A190] .pcibios_init+0x4c/0x18c                  
[C00000001F783EC0] [C0000000000093AC] .init+0x1bc/0x394                         
[C00000001F783F90] [C000000000023364] .kernel_thread+0x4c/0x68                  
PCI: Transparent bridge - 0000:00:01.0                                          


-- 
dwmw2

