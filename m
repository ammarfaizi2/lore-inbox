Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269411AbRHLUGK>; Sun, 12 Aug 2001 16:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269412AbRHLUGB>; Sun, 12 Aug 2001 16:06:01 -0400
Received: from imo-m05.mx.aol.com ([64.12.136.8]:7659 "EHLO imo-m05.mx.aol.com")
	by vger.kernel.org with ESMTP id <S269411AbRHLUFy>;
	Sun, 12 Aug 2001 16:05:54 -0400
Message-ID: <3B76E1D1.5020304@netscape.net>
Date: Sun, 12 Aug 2001 16:06:41 -0400
From: ambx1 <ambx1kml@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PnP BIOS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently began a project that will make Linux a PnP OS (at least the 
386 arch).  I'm currently working on a PnP BIOS module for the Linux 
kernel.  I was able to find the PnP BIOS install structure but the BIOS 
calls are not working.  The PnP BIOS specifications say that 16 bit 
protect mode calls can only return data in the first 64 Ks of memory. 
The linux kernel starts at 1mb.  How can I write a call function?
Please include code examples if possible.  Thank you for your help and 
support.

Sincerely,
ambx1

PS:  the complete PnP BIOS specifications are available at 
http://www.microsoft.com/hwdev/respec/pnpspecs.htm.  Also I can give you 
  a copy in HTML format upon your request.

The following is an exert from apm.c.  I believe that a PnP BIOS call 
function would be very similar to this:
////////////////////////////////////////////////////////

static u8 apm_bios_call(u32 func, u32 ebx_in, u32 ecx_in,
    u32 *eax, u32 *ebx, u32 *ecx, u32 *edx, u32 *esi)
{
    APM_DECL_SEGS
    unsigned long   flags;

    __save_flags(flags);
    APM_DO_CLI;
    APM_DO_SAVE_SEGS;
    /*
     * N.B. We do NOT need a cld after the BIOS call
     * because we always save and restore the flags.
     */
    __asm__ __volatile__(APM_DO_ZERO_SEGS
        "pushl %%edi\n\t"
        "pushl %%ebp\n\t"
        "lcall %%cs:" SYMBOL_NAME_STR(apm_bios_entry) "\n\t"
        "setc %%al\n\t"
        "popl %%ebp\n\t"
        "popl %%edi\n\t"
        APM_DO_POP_SEGS
        : "=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx),
          "=S" (*esi)
        : "a" (func), "b" (ebx_in), "c" (ecx_in)
        : "memory", "cc");
    APM_DO_RESTORE_SEGS;
    __restore_flags(flags);
    return *eax & 0xff;
}

////////////////////////////////////////////////////

The following is an exert from the PnP BIOS Specifications (Too big to 
include the whole thing):

This specification has been made available to the public. You are hereby 
granted the right to use, implement, reproduce, and distribute this 
specification with the foregoing rights at no charge. This specification 
is, and shall remain, the property of Compaq Computer Corporation 
("Compaq") Phoenix Technologies LTD ("Phoenix") and Intel corporation 
("Intel").

NEITHER COMPAQ, PHOENIX NOR INTEL MAKE ANY REPRESENTATION OR WARRANTY 
REGARDING THIS SPECIFICATION OR ANY PRODUCT OR ITEM DEVELOPED BASED ON 
THIS SPECIFICATION. USE OF THIS SPECIFICATION FOR ANY PURPOSE IS AT THE 
RISK OF THE PERSON OR ENTITY USING IT. COMPAQ, PHOENIX AND INTEL 
DISCLAIM ALL EXPRESS AND IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED 
TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
PURPOSE AND FREEDOM FROM INFRINGEMENT. WITHOUT LIMITING THE GENERALITY 
OF THE FOREGOING, NEITHER COMPAQ, PHOENIX NOR INTEL MAKE ANY WARRANTY OF 
ANY KIND THAT ANY ITEM DEVELOPED BASED ON THIS SPECIFICATION, OR ANY 
PORTION OF IT, WILL NOT INFRINGE ANY COPYRIGHT, PATENT, TRADE SECRET OR 
OTHER INTELLECTUAL PROPERTY RIGHT OF ANY PERSON OR ENTITY IN ANY COUNTRY.

4.4 Plug and Play Installation Check

This section describes the method for system software to determine if 
the system has a Plug and Play BIOS. This Plug and Play installation 
check indicates whether the system BIOS support for accessing the 
configuration information about the devices on the systemboard is 
present and the entry point to these BIOS functions. This method 
involves searching for a signature of the ASCII string $PnP in system 
memory starting from F0000h to FFFFFh at every 16 byte boundary. This 
signature indicates the system may have aPlug and Play BIOS and 
identifies the start of a structure that specifies the entry point of 
the BIOS code which implements the support described in this document. 
The system software can determine if the structure is valid by 
performing a Checksum operation.

The method for calculating the checksum is to add up Length bytes from 
the top of the structure, including the Checksum field, into an 8-bit 
value. A resulting sum of zero indicates a valid checksum operation.

The entry points specified in this structure are the software interface 
to the BIOS functions. The structure element that specifies the 16-bit 
protected mode entry point will allow the caller to construct a 
protected mode selector for calling this support.

Signature is represented as the ASCII string "$PnP", where byte 0='$' 
(24h), byte 1='P' (50h),byte 2='n' (6Eh), and byte 3='P' (50h).

Version - This is a BCD value that implies a level of compliance with 
major (high nibble) and minor (low nibble) version changes of the Plug 
and Play BIOS specification. For example, the BCD value 10h would be 
interpreted as version 1.0.

Length - Length of the entire Installation Structure expressed in bytes. 
The length count starts at the Signature field.

The Control field is a bit-field that provides system capabilities 
information.

bits 15:2: Reserved (0)
bits 1:0: Event notification mechanism
00=Event notification is not supported
01=Event notification is handled through polling
10=Event notification is asynchronous (at interrupt time)


Checksum - The method for calculating the checksum is to add up the 
number of bytes in the Installation Structure, including the Checksum 
field, into an 8-bit value. A resulting sum of zero indicates a valid 
checksum.

The Event notification flag address specifies the physical address of 
the Event Flag if event notification is handled through polling. When 
event notification is handled through polling, bit 0 of the Event Flag 
will be set when a system event occurs. System software will monitor or 
poll the Event Flag for notification of an event.

If events are handled through asynchronous notification, the system BIOS 
will specify a system device node which can be obtained from the Get 
Node runtime function. The system device node for asynchronous event 
management will be identified through the device identifier field in the 
device node data structure and will specify the IRQ number and an I/O 
port address. This event system device node can be defined in one of two 
ways. First, the device node can follow the generic implementation in 
which the device identifier is PNP0C03, and the interrupt number and I/O 
address assigned are system specific. The only requirement with the 
generic implementation is that the I/O address bit used for detecting 
the source of the interrupt and clearing the interrupt line is bit 0. If 
bit 0 of this I/O address is set to 1, then the interrupt was generated 
due to a system event. The interrupt service routine should reset the 
interrupt line by clearing bit 0 at the specified I/O address. All other 
bits read from the I/O address should not be modified. The second way 
the event system device node can be defined is implementation specific 
where the system vendor must supply their own device identifier and 
whatever resources are required for servicing the event interrupt. This 
method will require a specific device driver associated with the device 
node identifier to support the event notification interface.

System software should check the Control field to determine the event 
notification method implemented on the system.

Refer to the Event Notification Interface section for more information 
on events.

The Real Mode 16-Bit interface is basically the segment:offset of the 
entry point.

The 16-Bit Protected Mode interface specifies the code segment base 
address so that the caller can construct the descriptor from this 
segment base address before calling this support from protected mode. 
The offset value is the offset of the entry point. It is assumed that 
the 16-Bit Protected Mode interface is sufficient for 32-Bit Protected 
Mode callers.

The caller must also construct data descriptors for the functions that 
return information in the function arguments that are pointers. The only 
limitation is that the pointer offset can only point to the first 64K 
bytes of a segment.

If a call is made to these BIOS functions from 32-bit Protected Mode, 
the 32-bit stack will be used for passing any stack arguments to the 
Plug and Play BIOS functions. However, it is important to note that the 
Plug and Play BIOS functions are not implemented as a full 32-bit 
protected mode interface and will access arguments on the stack as a 
16-bit stack frame. Therefore, the caller must ensure that the function 
arguments are pushed onto the stack as 16-bit values and not 32-bit 
values. The stack parameter passing is illustrated in Figure 4.4.1 below.

<file:///home/adam/Projects/LAHD%20Project/PnP%20Specifications/sv13913905.gif>

Figure 4.4.1 - 16-bit Stack Frame on 32-bit Stack

The Plug and Play system BIOS can determine whether the stack is a 
32-bit stack or a 16-bit stack in 16-bit and 32-bit environments through 
the use of the LAR - Load Access Rights Byte Instruction. The LAR 
instruction will load the high order doubleword for the specified 
descriptor. By loading the access rights for the current stack segment 
selector, the system BIOS can check the B-bit (Big bit) of the stack 
segment descriptor which identifies the stack segment descriptor as 
either a 16-bit segment (B-bit clear) or a 32-bit segment (B-bit set).

In addition to executing the LAR command to get the entry point stack 
size, the BIOS code should avoid ADD BP,X type stack operands in runtime 
service code paths. These operands carry the risk of faulting if the 
32-bit stack base happens to be close to the 64K boundary. For the 
16-Bit Protected Mode interface, it is assumed that the segment limit 
fields will be set to 64K. The code segment must be readable. The 
current I/O permission bit map must allow accesses to the I/O ports that 
the system BIOS may need access to in order to perform the function. The 
current privilege level (CPL) must be less than or equal to I/O 
privilege level. This will allow the Plug and Play BIOS to use sensitive 
instructions such as CLI and STI.

The OEM Device Identifier field provides a means for specifying a device 
identifier for the system. The format of the OEM Device Identifier 
follows the format specified for EISA product identifiers. A system 
identifier is not required and if not specified, this field should be 0.

The entry point is assumed to have a function prototype of the form,

int FAR (*entryPoint)(int Function, ...);

and follow the standard 'C' calling conventions.

System software will interface with all of the functions described in 
this specification by making a far call to this entry point. As noted 
above, the caller will pass a function number and a set of arguments 
based on the function being called. Each function will also include an 
argument which specifies a data selector which will allow the Plug and 
Play BIOS to access and update variables within the system BIOS memory 
space. This data selector parameter is required for protected mode 
callers. The caller must create a data segment descriptor using the 
16-bit Protected Mode data segment base address specified in the Plug 
and Play Installation Structure, a limit of 64KB, and the descriptor 
must be read/write capable. Real mode callers are required to set this 
parameter to the Real Mode 16-bit data segment address specified in the 
Plug and Play Installation Structure.

Any functions described by this specification which are not supported 
should return the FUNCTION_NOT_SUPPORTED return code. The function 
return codes are described in Appendix C of this specification.

///another exert - this is a sample function of the PnP BIOS///

4.5.2 Function 1 - Get System Device Node

Synopsis:

int FAR (*entryPoint)(Function, Node, devNodeBuffer, Control, BiosSelector);
int Function; /* PnP BIOS Function 1 */
unsigned char FAR *Node; /* Node number/handle to retrieve */
struct DEV_NODE FAR *devNodeBuffer; /* Buffer to copy device node data to */
unsigned int Control; /* Control Flag */
unsigned int BiosSelector; /* PnP BIOS readable/writable selector */

Description:

Required. This function will copy the information for the specified 
System Device Node into the buffer specified by the caller. The Node 
argument is a pointer to the unique node number (handle). If Node 
contains 0, the system BIOS will return the first System Device Node. 
The devNodeBuffer argument contains the pointer to the caller's memory 
buffer. On return, Node will be updated with the next node number, or if 
there are no more nodes, it will contain FFh. The System Device Node 
data will be placed in the specified memory buffer.

The Control flag provides a mechanism for allowing the system software 
to request a node that indicates either how the specified systemboard 
device is currently configured or how it is configured for the next 
boot. Control is defined as:

Bits 15:2: Reserved (0)
Bit 1: 0=Do not get the information for how the device will be 
configured for the next boot.
1=Get the device configuration for the next boot (static configuration).
Bit 0: 0=Do not get the information for how the device is configured 
right now.
1=Get the information for how the device is configured right now.

If Control flag is 0, neither bit 0 nor bit 1 is set, or if both bits 
are set, this function should return BAD_PARAMETER.

The BiosSelector parameter enables the system BIOS, if necessary, to 
update system variables that are contained in the system BIOS memory 
space. If this function is called from protected mode, the caller must 
create a data segment descriptor using the 16-bit Protected Mode data 
segment base address specified in the Plug and Play Installation Check 
data structure, a limit of 64KB, and the descriptor must be read/write 
capable. If this function is called from real mode, BiosSelector should 
be set to the Real Mode 16-bit data segment address as specified in the 
Plug and Play Installation Check structure. Refer to section 4.4 above 
for more information on the Plug and Play Installation Check Structure 
and the elements that make up the structure.

The function is available in real mode and 16-bit protected mode.

Returns:

0 if successful - SUCCESS
!0 if an error (Bit 7 set) or a warning occurred - error code (The 
function return codes are described in Appendix C)

The FLAGS and registers will be preserved, except for AX which contains 
the return code.

Example:

The following example illustrates how the 'C' style call interface could 
be made from an assembly language module:

.
.
.
push Bios Selector
push Control Flag
push segment/selector of devNodeBuffer ; pointer to devNodeBuffer
push offset of devNodeBuffer
push segment/selector of Node ; pointer to Node number
push offset of Node
push GET_DEVICE_NODE ; Function 1
call FAR PTR entryPoint
add sp,14 ; Clean up stack
cmp ax,SUCCESS ; Function completed successfully?
jne error ; No-handle error condition





