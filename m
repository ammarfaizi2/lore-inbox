Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbUBXUGm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUBXUGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:06:42 -0500
Received: from zadnik.org ([194.12.244.90]:51157 "EHLO lugburz.zadnik.org")
	by vger.kernel.org with ESMTP id S262432AbUBXUFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:05:51 -0500
Date: Tue, 24 Feb 2004 22:05:33 +0200 (EET)
From: Grigor Gatchev <grigor@zadnik.org>
To: linux-kernel@vger.kernel.org
Subject: A Layered Kernel: Proposal
Message-ID: <Pine.LNX.4.44.0402242147460.11666-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A Layered Kernel
Proposal

The idea is to structure logically the kernel into two (or more) layers,
with explicitly defined interfaces between them.

Not a Microkernel

Some of my friends decided that this is actually a (partial) microkernel
idea. Not so:

- a microkernel is _physically_ divided into separate modules, while
logically it may consist of one or more layers;
- a layered kernel is _logically_ divided into layers, while physically
it may consist of one or more modules.

A microkernel may be (and often is) logically single-layered. A
many-layered kernel may be compiled as a big kernel.

Comparison

Both models have advantages. Single layer provides for better
integration, and apparently saving some work. Multi-layer provides for
better security, abstraction, code, and eventually quality.

Traditionally, Unixes use a layered approach - its assets have proven to
give more than the single-block. So, a layered kernel may be more natural
to a Unix-rooted system, and may give better results.

Details

Currently, it seems reasonable to form two layers: Resources and
Personality.

The Resources layer is the natural place for the low-level stuff - device
drivers, basic sheduler, basic memory management and protection, etc.

The Personality layer is the place for the Linux API and ABI, etc.

Some parts, eg. filesystems, TCP/IP stack etc, may bear a discussion over
their exact place. If need, an intermediate layer may be defined.

Each layer draws resources from the lower one, adds functionality on its
top, and possibly changes or hides some of its functionalities,
class-like. It runs the upper layer in encapsulation, eg. protected mode,
and works on top of the lower layer (Resources - over the physical
hardware). Possibly a lower layer can run simultaneously two or more
upper layers, in a multi-tasking way.

If a layer is a separate file, can be called like a program. If part of a
"big kernel", can be called directly, or through exported hooks. Other
models are possible, too.

A layer may be emulated by a layer interface emulator. For example, you
may run a Resources emulator as a program, and a standard Personality
over it, achieving "kernel over kernel". Configuring the emulator, you
pass to the child kernel, and its users and software, a virtual machine
of your choice.

Advantages

Improved source: A well defined inter-layer interface separates logically
the kernel source into more easily manageable parts. It makes the testing
easier. A simple and logical lower layer interface makes learning the
base and writing the code easier; a simple and logical upper layer
interface enforces and helps clarity in design and implementation. This
may attract more developers, ease the work of the current ones, and
increase the kernel quality while decreasing the writing efforts. The
earlier this happens, the better for us all.

Anti-malware protection: Sources of potentially dangerous content can be
filtered between the kernel layers by hooked or compiled-in modules. As
with most other advantages, this is achievable in a non-layered kernel
too, but is more natural in a layered one. Also, propagation of malware
between layers is mode difficult.

Security: A layer, eg. Personality, if properly written, is eventually a
sandbox. Most exploits that would otherwise allow a user to gain
superuser access, will give them control over only this layer, not over
the entire machine. More layers will have to be broken.

Sandboxing: A layer interface emulator of a lower, eg. Resources layer
can pass a configurable "virtual machine" to an upper, eg. Personality
layer. You may run a user or software inside it, passing them any
resources, real or emulated, or any part of your resources. All
advantages of a sandbox apply.

User nesting: The traditional Unix user management model has two levels:
superuser (root) and subusers (ordinary users). Subusers cannot create
and administrate their subusers, install system-level resources, etc.
Running, however, a subuser in their own virtual machine and Personality
layer as its root, will allow tree-like management of users and resources
usage/access. (Imagine a much enhanced chroot.)

Platforming: It is much easier to write only a Personality layer than an
entire kernel, esp. if you have a layer interface open standard as a
base. Respectively, it's easier to write only a Resources layer, adding a
new hardware to the "Supported by Linux" list. This will help increasing
supported both hardware and platforms. Also, thus you may run any
platform on any hardware, or many platforms concurrently on the same
hardware.

Heterogeneous distributed resources usage: Under this security model,
networks of possibly different hardware may share and redistribute
resources, giving to the users resource pools. Pools may be dynamical,
thus redistributing the resources flexibly. This mechanism is potentially
very powerful, and is inherently consistent with the open source spirit
of cooperativity and freedom.

Disadvantages:

More work to start: Initially the model change will take more effort.
(Most will be spent on clarifying and improving the code; most of the
layered model requirements are actually code quality requirements.
Without the new model, the bad design/code correction can be left for a
later stage.)

Performance: Badly designed and/or implemented inter-layer interfaces may
slow down the kernel speed, decreasing the system performance.

Compatibility: Even if the new model is 100% compatible with old
upper-level software, in practice it will surface better the advantages
of some newer stuff, eg. sysfs, and will increase the stress on them,
thus obsoleting sooner some old software. With the old model, the change
may be delayed further.

Other issues:

Need for it: Without any consideration for a layered model, the kernel
source is already structured in a way convenient for going with it; in a
sense, most of the work is already done. Which shows that the need for a
layered model is inherent to the kernel, even if not explicitly defined
and noticed. This way we just follow the system logic.

Authority: If not approved by the top developers, the restructuring may
fork the kernel development. As a result, the layered model may not be
able to gain sufficient resources to survive. The standard model will
probably survive, but may also suffer a loss of developers.

The right moment: The best moment for starting the change is when a new
kernel is declared stable version, and the tree for the next development
version is to be formed. This doesn't happen often, and the change will
be more difficult in another time. (That is why this proposal is made
now.)

Why all this?

Like the mutations, radical ideas are most often bad. Banning them as a
principle, however, may eventually doom Linux to a dinosaur fate. (And we
tend to do it - lately big improvements come to Linux only from outside.
The ELF format, sysfs, NUMA support... However, BSD, Solaris and IRIX
seem to fade; soon we will have only Windows to rely on for new
kernel-level things.)

The advantages of the idea above seems to overweight the disadvantages;
even its disadvantages have strong positive traits. Is it possible that a
discussion may prove it good?


Grigor Gatchev


