Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262726AbSJHCxE>; Mon, 7 Oct 2002 22:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262740AbSJHCxE>; Mon, 7 Oct 2002 22:53:04 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:1271 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S262726AbSJHCxC>; Mon, 7 Oct 2002 22:53:02 -0400
Date: Mon, 7 Oct 2002 22:58:57 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40-ac4  kernel BUG at slab.c:1477!
Message-ID: <20021008025857.GB1848@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3DA03B17.8010501@colorfullife.com> <20021006224326.GA1675@Master.Wizards>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021006224326.GA1675@Master.Wizards>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 06:43:26PM -0400, Murray J. Root wrote:
> On Sun, Oct 06, 2002 at 03:31:03PM +0200, Manfred Spraul wrote:
> > > This happens at random during boot when loading modules.
> > > About half of the time ide-scsi works fine.
> > > The system continues to boot after the BUG with /dev/hdc unaccessible.
> > 
> > from mm/slab.c:
> > 
> > 1475 if (xchg((unsigned long *)objp, RED_MAGIC1) != RED_MAGIC2)
> > 1476     /* Either write before start, or a double free. */
> > 1477     BUG();
> > 
> > You run an uniprocessor kernel, with slab debugging enabled, and the 
> > red-zoning test notices a write before the beginning of the buffer 
> > during scsi_probe_and_add_lun, with ide-scsi.
> > 
> > Andre: Do you know if ide-scsi makes any assumptions about memory 
> > alignment of the input buffers? With slab debugging disabled, the 
> > alignment is 32 or 64 bytes, with debugging enabled, it's just 4 byte 
> > [actually sizeof(void*)] aligned.
> > 
> > Murray, could you apply the attached patch? It dumps the redzone value 
> > during scsi_probe_and_add_lun. Hopefully this will help to find who 
> > corrupts the buffers.
> > 
> After patching:
> Soft reboot:
>    kernel oops - rebooted (I'll try to get the oops data from a pic I 
> took of the screen later).
> 
> Hard reboot:
>  SCSI subsystem driver Revision: 1.00
>  scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>  scsi_result: c0334084, start 170fc2a5h.
>  scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 0 lun 0
>  scsi_result: c0334084, start 170fc2a5h.
>  scsi_result: c0334084, start 170fc2a5h.
>    Vendor:           Model:                   Rev:     
>    Type:   Direct-Access                      ANSI SCSI revision: 00
>  hdc: lost interrupt
>  hdc: status timeout: status=0xd0 { Busy }
>  hdc: DMA disabled
>  hdc: drive not ready for command
>  hdc: ATAPI reset complete
>  scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 0 lun 0
>  scsi scan: host 0 channel 0 id 0 lun 0 identifier too long, length 116, max 80. Device might be improperly identified.
>  scsi_result: c0334084, start 5a2cf071h.
>  scsi_result: c0334084, start 5a2cf071h.
>  ------------[ cut here ]------------
>  kernel BUG at slab.c:1477!
>  invalid operand: 0000
>  ide-scsi scsi_mod rtc  
>  CPU:    0
>  EIP:    0060:[<c01365ee>]    Not tainted
>  EFLAGS: 00010016
>  EIP is at kmem_cache_free_one+0x7e/0x240
>  eax: 5a2cf071   ebx: c1008cf0   ecx: c02db214   edx: c1b0d5fc
>  esi: c0334080   edi: c0334000   ebp: f784fe28   esp: f784fe04
>  ds: 0068   es: 0068   ss: 0068
>  Process insmod (pid: 280, threadinfo=f784e000 task=f7956800)
>  Stack: ffffdaf6 c034198b 00000246 0000002b c0334000 c1b0d5fc c1008cf0 c0334084 
>         00008cf0 f784fe48 c0135bcf c1b0d5fc c0334084 00000286 c0334084 f7cd5a00 
>         c1b645ac f784fe7c fa8eee71 c0334084 c0334084 5a2cf071 c0334084 f784fe6c 
>  Call Trace:
>   [<c0135bcf>]kfree+0x5f/0xb0
>   [<fa8eee71>]scsi_probe_and_add_lun+0xd1/0x220 [scsi_mod]
>   [<fa8ef11e>]scsi_scan_target+0x4e/0x90 [scsi_mod]
>   [<fa8ef391>]scan_scsis+0x91/0x17c [scsi_mod]
>   [<fa8f8d92>].rodata.str1.32+0x392/0x3e6 [ide-scsi]
>   [<fa8e79d2>]scsi_register_host_Rb0dc194c+0x222/0x350 [scsi_mod]
>   [<fa8f84fe>]init_module+0x1e/0x30 [ide-scsi]
>   [<fa8f96c0>]idescsi_template+0x0/0x80 [ide-scsi]
>   [<c011ab1c>]sys_init_module+0x53c/0x690
>   [<fa8f7060>]idescsi_discard_data+0x0/0x40 [ide-scsi]
>   [<fa8f89cf>]__ksymtab+0x0/0x31 [ide-scsi]
>   [<fa8f8fac>].kmodtab+0x0/0xc [ide-scsi]
>   [<fa8f7060>]idescsi_discard_data+0x0/0x40 [ide-scsi]
>   [<c010781b>]syscall_call+0x7/0xb
>  
>  Code: 0f 0b c5 05 f2 2c 2a c0 8b 4d f0 89 f2 b8 71 f0 2c 5a 8b 59 
> 

Same thing in 2.5.41-ac1

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

