Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUJYJL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUJYJL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 05:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUJYJL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 05:11:28 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:60257 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261726AbUJYJLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 05:11:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=SegqQhKU62o8w0Mq/2l9Xrz0KCUisVQucsxviKpY3HNDnJqqWUHxXDxJSE0yeLO8ikXheIrQTELgtVIVQSQED+1e/MIx622MakvN5lMEFMaKrBeQS2FNLbn/0FlDAY4FoGiBqxOCRiAvguqKkN3jjdznn1PBN7nX50u5WkHE534=
Message-ID: <14dd4ead04102502115a9903d8@mail.gmail.com>
Date: Mon, 25 Oct 2004 17:11:00 +0800
From: jonathan li <spiderium@gmail.com>
Reply-To: jonathan li <spiderium@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: oops on kernel-2.6-0
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, all

   I want to use oprofile, but after the following steps,
   # opcontrol --setup --vmlinux=/boot/vmlinux
   # opcontrol --start

   I get oops as follows:

Unable to handle kernel paging request at virtual address ffffd340
printing eip:
e09a7867
*pde = 00002067
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<e09a7867>]    Tainted: P   VLI
EFLAGS: 00010246
EIP is at nmi_cpu_setup+0x27/0x40 [oprofile]
eax: e09ab844   ebx: 00000000   ecx: 00000000   edx: ffffffff
esi: e09aaa00   edi: d6995684   ebp: dfe34ac0   esp: d29d7f24
ds: 007b   es: 007b   ss: 0068
Process oprofiled (pid: 1828, threadinfo=d29d6000 task=d306b900)
Stack: e09a789a 00000000 e09a6039 ffffffea d2fbaa80 e09a6b8e d2fbaa80 d34f6380
      c015155c d34f6380 d2fbaa80 00000000 dd541000 00000000 d29d6000 c0151450
      d2e0e280 dfe34ac0 00000000 d2e0e280 dfe34ac0 dfe37f80 d34fcd00 08050fc8
Call Trace:
[<e09a789a>] nmi_setup+0x1a/0x40 [oprofile]
[<e09a6039>] oprofile_setup+0x39/0xa0 [oprofile]
[<e09a6b8e>] event_buffer_open+0x3e/0x70 [oprofile]
[<c015155c>] dentry_open+0xfc/0x190
[<c0151450>] filp_open+0x50/0x60
[<c01517eb>] sys_open+0x3b/0x70
[<c010af47>] syscall_call+0x7/0xb

Code: 75 d6 eb cf a1 40 b8 9a e0 68 44 b8 9a e0 ff 50 08 68 44 b8 9a
e0 e8 d9 fe ff ff 58 a1 40 b8 9a e0 5a 68 44 b8 9a e0 ff 50 0c 58 <a1>
40 d3 ff ff c7 05 40 d3 ff ff 00 04 00 00 a3 4c b8 9a e0 c3

 It seems that kernel was panic in this function:

static void nmi_cpu_setup(void * dummy)
{
       int cpu = smp_processor_id();
       struct op_msrs * msrs = &cpu_msrs[cpu];
       model->fill_in_addresses(msrs);
       nmi_save_registers(msrs);
       spin_lock(&oprofilefs_lock);
       model->setup_ctrs(msrs);
       spin_unlock(&oprofilefs_lock);
       saved_lvtpc[cpu] = apic_read(APIC_LVTPC);
       apic_write(APIC_LVTPC, APIC_DM_NMI);
}

  the result of objdump -d oprofile.ko as follows:

00001840 <nmi_cpu_setup>:
   1840:       a1 40 02 00 00          mov    0x240,%eax
   1845:       68 44 02 00 00          push   $0x244
   184a:       ff 50 08                call   *0x8(%eax)
   184d:       68 44 02 00 00          push   $0x244
   1852:       e8 d9 fe ff ff          call   1730 <nmi_save_registers>
   1857:       58                      pop    %eax
   1858:       a1 40 02 00 00          mov    0x240,%eax
   185d:       5a                      pop    %edx
   185e:       68 44 02 00 00          push   $0x244
   1863:       ff 50 0c                call   *0xc(%eax)
   1866:       58                      pop    %eax
   1867:       a1 40 d3 ff ff          mov    0xffffd340,%eax
   186c:       c7 05 40 d3 ff ff 00    movl   $0x400,0xffffd340
   1873:       04 00 00
   1876:       a3 4c 02 00 00          mov    %eax,0x24c
   187b:       c3                      ret
   187c:       8d 74 26 00             lea    0x0(%esi,1),%esi

   Why APIC_LVTPC get virtual address 0xffffd340? Anybody has
confront this question? please point me how to resolve this question?
