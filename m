Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934401AbWKUQHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934401AbWKUQHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 11:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934397AbWKUQHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 11:07:11 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:56482 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S934401AbWKUQHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 11:07:09 -0500
Message-ID: <4563242D.9050901@f2s.com>
Date: Tue, 21 Nov 2006 16:07:09 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Thunderbird 2.0a1 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: kernel-discuss@handhelds.org
Subject: RFC - platform device, IRQs and SoC devices 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.

Im working on some SoC type devices attached to the system bus of my ARM 
devboard in an isa-like way.

The devices are small SoC (System On Chip) types, with one IRQ routed to 
the half dozen (sub)devices on board the SoC.

At present, I am using a platform driver for the 'core' which handles 
IRQ routing and device enumeration, and is currently passing the IRQ to 
be used by the subdevices in a struct resource (along with two or three 
IOMEM resources).

this, however means that the subdevice resource definitions must be 
copied in order that the IRQ field can be set dynamically.

One solution would be for there to be a method by which the subdevice 
can query the SoC core device for the base of its IRQ range, which would 
allow the subdevice data to be declared as a constant and not copied. 
This makes the declaration of the subdevices in the main driver very 
neat and compact.

can this be done with a 'platform device' or is this simply not possible?

the real problem seems (to me) to be that struct resource is held as an 
array. If it were a linked list, then I could hold all but the subdevice 
IRQ in const data and simply 'tack on' a single dynamically created IRQ 
resource to it.

I propose that a 'next' field be added to the struct resource. All 
existing code could remain the same for now, and continue to work, 
whilst newer device drivers could use the next-> field to taverse the 
list rather than treat it as an array.

if all 'linked' entries come before 'array style' ones, then the 
num_resources field would change to mean 'num_array_style_resources' and 
the last 'linked' type resource would point to the head of the array. 
The traversal routines would simply count the array offset from the 
first 'array style' entry (with a NULL next field) or, if num_resources 
is not set, assume all resources are linked, and the NULL ends the list 
of resources.

This would allow for both statically allocated const arrays of struct 
resource as we use now, and dynamically allocated resources, or a mix of 
both for the few weird cases like my problem above.

Summary:

add struct resource *next; to struct resource.
rename num_resources as resource_array_len to indicate it only counts 
the number of resources listed in an array
allow resources to be added dynamically by altering the pointer to the 
firts resource and using that resources next pointer to point to the old 
list head (OR) the old array head.

possible enhancements:

get_first_resource() - return first resource added, making it easy to 
locate the first array type entry (if present)
remove_resource() - obvious, but perhaps not very useful.
