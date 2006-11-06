Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753335AbWKFQEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbWKFQEa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbWKFQEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:04:30 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:54749 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1753335AbWKFQE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:04:29 -0500
Date: Mon, 6 Nov 2006 11:03:53 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 7/11] i386: Kallsyms generate relocatable symbols
Message-ID: <20061106160353.GD26091@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061023192456.GA13263@in.ibm.com> <20061023193748.GH13263@in.ibm.com> <20061106154857.003dc9d9@cad-250-152.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106154857.003dc9d9@cad-250-152.norway.atmel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 03:48:57PM +0100, Haavard Skinnemoen wrote:
> On Mon, 23 Oct 2006 15:37:48 -0400
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> 
> > Add the _text symbol definitions to the architectures which don't
> > define it otherwise linker will fail.
> 
> I get lots of this when building latest -mm for avr32:
> 
> .tmp_kallsyms2.S:643: Warning: right operand is a bignum; integer 0
> assumed
> 
> Reverting this patch makes the warnings go away. I think it's
> because on avr32, .init is the first section, not .text, so many of the
> offsets become negative and kallsyms doesn't seem to handle this very
> well. Here's a few lines from .tmp_kallsyms2.S:
> 
> kallsyms_addresses:
>         PTR     _text + 0xffffffffffff4000
>         PTR     _text + 0xffffffffffff4000
> 
> Any idea how to fix this? Could we introduce a new symbol that always
> marks the start of the image perhaps?
>

Hi Haavard,

Does the attached patch solve the issue for you?

Thanks
Vivek
 


o On some platforms like avr32, section init comes before .text and 
  not necessarily a symbol's relative position w.r.t _text is positive. 
  In such cases assembler detects the overflow and emits warning. This
  patch fixes it.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 scripts/kallsyms.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff -puN scripts/kallsyms.c~i386-reloc-kallsyms-_text-symbol-relative-address-fix scripts/kallsyms.c
--- linux-2.6.19-rc4-reloc/scripts/kallsyms.c~i386-reloc-kallsyms-_text-symbol-relative-address-fix	2006-11-06 10:47:01.000000000 -0500
+++ linux-2.6.19-rc4-reloc-root/scripts/kallsyms.c	2006-11-06 10:47:01.000000000 -0500
@@ -277,8 +277,12 @@ static void write_src(void)
 	output_label("kallsyms_addresses");
 	for (i = 0; i < table_cnt; i++) {
 		if (toupper(table[i].sym[0]) != 'A') {
-			printf("\tPTR\t_text + %#llx\n",
-				table[i].addr - _text);
+			if (_text <= table[i].addr)
+				printf("\tPTR\t_text + %#llx\n",
+					table[i].addr - _text);
+			else
+				printf("\tPTR\t_text - %#llx\n",
+					_text - table[i].addr);
 		} else {
 			printf("\tPTR\t%#llx\n", table[i].addr);
 		}
_
