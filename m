Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965378AbWI0GVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965378AbWI0GVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 02:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965380AbWI0GVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 02:21:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65183 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965378AbWI0GVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 02:21:34 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Aaron Durbin" <adurbin@google.com>
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Andi Kleen" <ak@suse.de>
Subject: Re: 2.6.18-mm1
References: <20060924040215.8e6e7f1a.akpm@osdl.org>
	<m1mz8mqd4a.fsf@ebiederm.dsl.xmission.com>
	<20060926201104.1bb1a193.akpm@osdl.org>
	<m1ac4lriz5.fsf@ebiederm.dsl.xmission.com>
	<8f95bb250609262244w423bea15pe15ec6a1c7ef1800@mail.google.com>
Date: Wed, 27 Sep 2006 00:20:19 -0600
In-Reply-To: <8f95bb250609262244w423bea15pe15ec6a1c7ef1800@mail.google.com>
	(Aaron Durbin's message of "Tue, 26 Sep 2006 22:44:39 -0700")
Message-ID: <m1odt1q198.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Aaron Durbin" <adurbin@google.com> writes:

> On 9/26/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Andrew Morton <akpm@osdl.org> writes:
>>
>> > On Tue, 26 Sep 2006 20:04:05 -0600
>> > ebiederm@xmission.com (Eric W. Biederman) wrote:
>> >
>> >> When I apply:
>> >> x86_64-mm-insert-ioapics-and-local-apic-into-resource-map
>> >>
>> >> My e1000 fails to initializes and complains about a bad eeprom checksum.
>> >> I haven't tracked this down to root cause yet and I am in the process of
>> > building
>> >> 2.6.18-mm1 with just that patch reverted to confirm that is the only cause.
>> >>
>> >> I could not see anything obvious in the patch.  I don't have a clue the
> patch
>> >> could be triggering the problem I'm seeing.
>> >>
>> >> At a quick visual diff I'm not seeing any other differences in the kernel
> boot
>> >> logs, or in /proc/iomem.
>> >
>> > This bit looks fishy:
>> >
>> >  GSI 17 sharing vector 0x4A and IRQ 17
>> >  PCI->APIC IRQ transform: 0000:05:0c.0[A] -> IRQ 17
>> > +PCI: Cannot allocate resource region 8 of bridge 0000:00:02.0
>> > +PCI: Cannot allocate resource region 8 of bridge 0000:01:00.0
>> > +PCI: Cannot allocate resource region 8 of bridge 0000:01:00.2
>> > +PCI: Cannot allocate resource region 0 of device 0000:01:00.1
>> > +PCI: Cannot allocate resource region 0 of device 0000:01:00.3
>> > +PCI: Cannot allocate resource region 0 of device 0000:03:04.0
>> > +PCI: Cannot allocate resource region 0 of device 0000:03:04.1
>> >  PCI-GART: No AMD northbridge found.
>> >  PCI: Bridge: 0000:01:00.0
>> >    IO window: disabled.
>> > -  MEM window: fe000000-fe0fffff
>> > +  MEM window: e2000000-e20fffff
>> >    PREFETCH window: fd000000-fdffffff
>> >  PCI: Bridge: 0000:01:00.2
>> >    IO window: 1000-1fff
>> > -  MEM window: fe100000-fe1fffff
>> > +  MEM window: e2100000-e21fffff
>> >    PREFETCH window: disabled.
>> >  PCI: Bridge: 0000:00:02.0
>> >    IO window: 1000-1fff
>> > -  MEM window: fe000000-fe2fffff
>> > +  MEM window: e2000000-e22fffff
>> >    PREFETCH window: fd000000-fdffffff
>> >  PCI: Bridge: 0000:00:06.0
>> >    IO window: disabled.
>> > @@ -123,17 +131,17 @@
>> >  PCI: Bridge: 0000:00:1e.0
>> >    IO window: 2000-2fff
>> >    MEM window: fb000000-fc0fffff
>> > -  PREFETCH window: e2000000-e20fffff
>> >
>> >
>> > Wanna hack into arch/i386/pci/i386.c:pcibios_allocate_bus_resources() and
>> > see what is conflicting with what?
>>
>> Good catch.  Add that to the earlier /proc/iomem output.
>> > fe200000-fe200fff : IOAPIC 1
>> > fe201000-fe201fff : IOAPIC 2
>>
>> On that board I have ioapics on pci devices and it appears the way
>> the patch is reserving them it doesn't account for ioapics that
>> have that property.  I.e.  Those ioapics regions show up in lspci
>> on an ioapic pci device and the regions are specified with normal
>> base address registers.
>>
>
> That patch marks each IOAPIC resource as IORESOURCE_BUSY.  This why
> the pci allocation fails. I will post patch to fix this in the
> morning.

I'm not certain that is enough.  Please not that those bridge resources
are larger then the ioapics, and I believe you are reserving the ioapic
resources first.  So I don't believe simply clearing IORESOURCE_BUSY
is enough.  Also if you look because my ioapics are pci devices these
resource are already getting reserved.

Look below at devices 1:00.1 and 1:00.3

I think the correct solution is most likely to test to see if the
ioapic is in the ioapic legacy range and only to reserve it if that
is the case.  Although if we find all of the pci devices before we
reserve their resources we could remove your reservation for the
ioapics if we find a corresponding BAR, which would be cleaner
and more general then relying on a magic memory range.

# cat /proc/iomem
00000000-00000c3f : reserved
00000c40-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000effff : System RAM
000f0000-000fffff : System ROM
e2000000-e20fffff : PCI Bus #05
  e2000000-e201ffff : 0000:05:0c.0
fb000000-fc0fffff : PCI Bus #05
  fb000000-fbffffff : 0000:05:0c.0
  fc000000-fc000fff : 0000:05:0c.0
fd000000-fdffffff : PCI Bus #01
  fd000000-fdffffff : PCI Bus #02
    fd000000-fdffffff : 0000:02:03.0
fe000000-fe2fffff : PCI Bus #01
  fe000000-fe0fffff : PCI Bus #02
    fe000000-fe07ffff : 0000:02:03.0
  fe100000-fe1fffff : PCI Bus #03
    fe100000-fe11ffff : 0000:03:04.0
      fe100000-fe11ffff : e1000
    fe120000-fe13ffff : 0000:03:04.1
      fe120000-fe13ffff : e1000
  fe200000-fe200fff : 0000:01:00.1
  fe201000-fe201fff : 0000:01:00.3
fe300000-fe300fff : 0000:00:00.0
fe301000-fe301fff : 0000:00:01.0
fe302000-fe3023ff : 0000:00:1d.7
fe303000-fe3033ff : 0000:00:1f.1
100000000-11fffffff : System RAM

Eric
