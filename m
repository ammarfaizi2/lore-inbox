Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752466AbWCQAys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbWCQAys (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbWCQAys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:54:48 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:41734 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1752466AbWCQAyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:54:47 -0500
Message-ID: <441A0806.80308@vmware.com>
Date: Thu, 16 Mar 2006 16:51:18 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
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
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <20060315230012.GA1919@elf.ucw.cz>
In-Reply-To: <20060315230012.GA1919@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>> The question of licensing of such ROM code is a completely separate
>> issue.  We are not trying to hide some proprietary code by putting it
>> inside of a ROM to keep it hidden.  In fact, you can disassemble the
>> ROM code and see it quite readily - and you know all of the entry
>> points.
>>     
>
> Could you disassemble one entry point for us and describe how it works?
>   

000005e0 <stub_VMI_SwapPxE>:
     5e0:       e9 db 06 00 00          jmp    cc0 <VMI_SwapPxE>
     5e5:       0f 0b                   ud2a  

(The SwapPxE call does not fit in the 32-byte region).


00000cc0 <VMI_SwapPxE>:
     cc0:       83 ec 1c                sub    $0x1c,%esp
     cc3:       89 c1                   mov    %eax,%ecx
     cc5:       89 74 24 10             mov    %esi,0x10(%esp,1)
     cc9:       89 d6                   mov    %edx,%esi
     ccb:       89 7c 24 14             mov    %edi,0x14(%esp,1)
     ccf:       89 6c 24 18             mov    %ebp,0x18(%esp,1)
     cd3:       89 54 24 0c             mov    %edx,0xc(%esp,1)

(Save registers and call values on stack)

     cd7:       87 30                   xchg   %esi,(%eax)

(Atomically swap the PTE in the page)

     cd9:       0f b6 44 24 0c          movzbl 0xc(%esp,1),%eax

(Extract low byte of the PTE write just done)

     cde:       31 d2                   xor    %edx,%edx
     ce0:       09 f0                   or     %esi,%eax
     ce2:       a8 01                   test   $0x1,%al

(Were either the new or old PTE's present?)

     ce4:       74 11                   je     cf7 <VMI_SwapPxE+0x37>

(No?  jump forward to branch combination)

     ce6:       0f b6 44 24 0c          movzbl 0xc(%esp,1),%eax

(Extract low byte of the PTE write again)

     ceb:       31 f0                   xor    %esi,%eax

(Compute changed bits in PTE)

     ced:       a8 c7                   test   $0xc7,%al

(Have U/S, R/W, P, PS, D bits changed?)

     cef:       b8 01 00 00 00          mov    $0x1,%eax
     cf4:       0f 45 d0                cmovne %eax,%edx
     cf7:       84 d2                   test   %dl,%dl

(Combine above tests into one branch)

     cf9:       74 32                   je     d2d <VMI_SwapPxE+0x6d>

(If nothing interesting changed, return)

     cfb:       b8 54 00 00 fc          mov    $0xfc000054,%eax

(Load start of linear address translation lookaside)

     d00:       31 d2                   xor    %edx,%edx
     d02:       89 cf                   mov    %ecx,%edi
     d04:       39 08                   cmp    %ecx,(%eax)

(Compare stored lookaside translation address with address of PTE write)

     d06:       77 37                   ja     d3f <VMI_SwapPxE+0x7f>

(Greater? - next)

     d08:       39 48 04                cmp    %ecx,0x4(%eax)

(Compare stored lookaside translate address end with address of PTE write)

     d0b:       76 32                   jbe    d3f <VMI_SwapPxE+0x7f>

(Below/Equal? - next)

     d0d:       03 78 08                add    0x8(%eax),%edi

(Add translation offset to PTE address (perform VA->PA conversion))

     d10:       c7 04 24 00 00 00 00    movl   $0x0,(%esp,1)
     d17:       8b 54 24 0c             mov    0xc(%esp,1),%edx
     d1b:       bd 89 00 00 00          mov    $0x89,%ebp
     d20:       89 6c 24 04             mov    %ebp,0x4(%esp,1)
     d24:       31 c9                   xor    %ecx,%ecx
     d26:       89 f8                   mov    %edi,%eax
     d28:       e8 73 fd ff ff          call   aa0 <VMIEnqueue>

(Put arguments into order, and queue the PTE update)

     d2d:       89 f0                   mov    %esi,%eax
     d2f:       8b 74 24 10             mov    0x10(%esp,1),%esi
     d33:       8b 7c 24 14             mov    0x14(%esp,1),%edi
     d37:       8b 6c 24 18             mov    0x18(%esp,1),%ebp
     d3b:       83 c4 1c                add    $0x1c,%esp
     d3e:       c3                      ret

(Restore registers and return)

     d3f:       42                      inc    %edx
     d40:       83 c0 10                add    $0x10,%eax

(Move to next translation index)

     d43:       83 fa 03                cmp    $0x3,%edx
     d46:       7e bc                   jle    d04 <VMI_SwapPxE+0x44>

(Retry)

     d48:       89 cf                   mov    %ecx,%edi
     d4a:       eb c4                   jmp    d10 <VMI_SwapPxE+0x50>

(Default case - VA == PA, direct mapping assumed)


And this version may be easier for some of you to read:

/*
 * To convert virtual address to physical address, we must
 * keep a cache of currently mapped page tables.  This allows
 * us to perform the VA->PA conversion with guest help, which
 * is much faster than having to do a page table walk.  For the
 * Linux guest, when page tables are not in high memory, the
 * first mapping slot is always an identity map of physical
 * memory mapped at PAGE_OFFSET.
 */

static INLINE PA
VMITranslate(const LA la)
{ 
   HyperAddressMap *m;
   int i;
   m = &vmiHypervisorShared->pageTranslation[0];
   for (i = 0; i < VMI_LINEAR_MAP_SLOTS; i++, m++) {
      if (LIKELY(la >= m->startVA && la < m->endVA)) {
         return (m->physOffset + la);
      }
   }
   /* Assume identity mapped */
   return la;
}

/*
 * Note we read and write guest memory directly.  This
 * is safe for us because we use shadow page tables.  The
 * Xen ROM would perform similar conditional tests here to
 * figure out which hypercall it wants to make or decide
 * to write the PTE directly and trigger shadow
 */

VMICALL(SwapPxE, VM_PTE *const ptep, VM_PTE const pteval)
{
   VMI_ENTER;
   VM_PTE pteold;
  
   pteold = Atomic_ReadWrite((Atomic_uint32 *)ptep, pteval);
   if (VMIIsPTEInteresting(pteval, pteold)) {
      PA pa = VMITranslate((LA) ptep);
      VMIEnqueue(pa, pteval, 0, 0, HC_SetPxEAsync);
   }
   VMI_RETURN(pteold);
}

Herein lies one of our problems.  Atomic_ReadWrite comes from a private 
header file.  We need to copy all of these defines and inline functions 
into a distributable header file rather than a private one - separating 
public and private headers can be sort of like trying to straighten the 
vines of a giant thornbush.  Every time you straighten one, another 
wacks you in the head.  We have many, many build clients that depend on 
those same headers, and moving large amounts of things around is a 
tricky and painstaking process.  Not that it can't be done, just that it 
is not a simple copy and paste job.

Zach
