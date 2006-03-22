Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932903AbWCVWkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932903AbWCVWkM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932900AbWCVWgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:36:16 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:55568 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932899AbWCVWgB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:36:01 -0500
Message-ID: <4421D0B3.6090808@vmware.com>
Date: Wed, 22 Mar 2006 14:33:23 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 4/24] i386 Vmi inline implementation
References: <200603131802.k2DI22OK005657@zach-dev.vmware.com> <200603222112.52385.ak@suse.de>
In-Reply-To: <200603222112.52385.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 13 March 2006 19:02, Zachary Amsden wrote:
>
>   
>> +#define MAKESTR(x)              #x
>> +#define XSTR(x)                 MAKESTR(x)
>> +#define XCONC(args...)		args
>> +#define CONCSTR(x...)		#x
>> +#define XCSTR(x...)		CONCSTR(x)
>>     
>
> We have legions of these all over the tree. How about you put
> them into some central file and gc a few?
>   

Will do.  I think the XCSTR() is a new one though.. I've never seen it 
before, so I had to invent it.

>
>   
>> +/*
>> + * Propagate these definitions as strings up to C code for convenient use
>> + * in stringized assembler as pseudo-mnemonics; we must emit assembler
>> + * directives to generate equates for the VMI_CALL_XXX symbols, since they
>> + * will not be available otherwise to the assembler, and we can't emit
>> + * the C versions of these functions from within an inline assembler
>> + * string.
>> + */
>> +asm(".equ VMI_CALL_CUR, 0;\n\t");
>>     
>
> The standard way to do this is to use asm-offsets.c
>   

Almost.  This is a real shady thing to do, but this is used by C-code, 
not assembly, to propagate the constants for VMI_STI and VMI_CLI into 
the spinlock macros where they are referenced by inline assembly.  We 
just need defined constants, but I didn't want to do that yet as we are 
still changing the MMU portion of the interface to map better onto Xen 3.0.

>
>
>   
>> +#define VDEF(call)						\
>> +	asm (".equ VMI_CALL_" #call ", VMI_CALL_CUR;\n\t");	\
>> +	asm (".equ VMI_CALL_CUR, VMI_CALL_CUR+1;\n\t");
>> +VMI_CALLS
>>     
>
> Hmmm? This doesn't look like something a header file should be doing.
>
> How about you put that big list and the definition into a .c ?
>   

See note above.  Shady, I agree.

>   
>> +#if defined(CONFIG_VMI_C_CONVENTION)
>>     
>
> I don't think that file can be reviewed in any meaningful way before
> you don't get rid of the macro mess and the unneeded calling conventions.
>   

I sort of expected that.  It is a mess.  You should have seen it two 
months ago.  It was the most hideous gobbledygook I've ever written, but 
in the great tradition of hacking, it did the job.  The results are 
impressive, however.  Here is some disassembly of arch/i386/kernel/process.c

Disassembly of section .vmi.translation:

00000000 <.vmi.translation>:
   0:   e8 23 00 00 00          call   28 <.vmi.translation+0x28>
   5:   e8 24 00 00 00          call   2e <.vmi.translation+0x2e>
   a:   e8 23 00 00 00          call   32 <.vmi.translation+0x32>
   f:   e8 2a 00 00 00          call   3e <.vmi.translation+0x3e>

Here, you can see a bunch of VMI calls - annotated with the call number 
(used to index into the ROM). 

--Snip--

  55:   56                      push   %esi
  56:   e8 10 00 00 00          call   6b <.vmi.translation+0x6b>
  5b:   8d 64 24 04             lea    0x4(%esp,1),%esp

Here, a 4 argument hypercall, automatically emitted with regparm(3) 
convention and one stack argument.


And some use sites:

00000029 <default_idle>:
      29:       55                      push   %ebp
      2a:       89 e5                   mov    %esp,%ebp
      2c:       56                      push   %esi
      2d:       53                      push   %ebx
      2e:       fb                      sti   
      2f:       66                      data16
      30:       66                      data16
      31:       66                      data16
      32:       90                      nop

Note the automatic nop padding, out to the size of the emitted 
translation (5 byte call sequence).  And here, in switch to, the 
automatically generated padding for the calls in load_TLS 
(VMI_WriteGDTEntry, the 4 argument call shown above).  Note the perfect 
match between the 10 byte call sequence above and this code.

     b39:       89 0c d0                mov    %ecx,(%eax,%edx,8)
     b3c:       89 74 d0 04             mov    %esi,0x4(%eax,%edx,8)
     b40:       66                      data16
     b41:       66                      data16
     b42:       90                      nop   

The annotation table is less useful to look at in this form, but encodes 
the EIPs of the native sequences as well as the translations:

00000000 <.vmi.annotation>:
   0:   23 00                   and    (%eax),%eax
   2:   00 00                   add    %al,(%eax)
   4:   2e 00 00                add    %al,%cs:(%eax)
   7:   00 00                   add    %al,(%eax)
   9:   00 00                   add    %al,(%eax)
   b:   00 05 05 04 00 24       add    %al,0x24000405
  11:   00 00                   add    %al,(%eax)
  13:   00 62 00                add    %ah,0x0(%edx)
  16:   00 00                   add    %al,(%eax)
  18:   05 00 00 00 05          add    $0x5000000,%eax

