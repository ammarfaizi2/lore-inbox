Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbUCFSwA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 13:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUCFSv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 13:51:57 -0500
Received: from zadnik.org ([194.12.244.90]:11398 "EHLO lugburz.zadnik.org")
	by vger.kernel.org with ESMTP id S261703AbUCFSvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 13:51:40 -0500
Date: Sat, 6 Mar 2004 20:51:10 +0200 (EET)
From: Grigor Gatchev <grigor@serdica.org>
X-X-Sender: grigor@lugburz.zadnik.org
To: Christer Weinigel <christer@weinigel.se>
Cc: Grigor Gatchev <grigor@zadnik.org>, <linux-kernel@vger.kernel.org>
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <m365dqoym3.fsf@zoo.weinigel.se>
Message-ID: <Pine.LNX.4.44.0403062049560.13053-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here it is. Get your axe ready! :-)

---

Driver Model Types: A Short Description.

(Note:  This is NOT a complete description of a layer,
according to the kernel layered model I dared to offer.  It
concerns only the hardware drivers in a kernel.)


Direct binding models:

In these models, kernel layers that use drivers bind to
their functions more or less directly.  (The degree of
directness and the specific methods depend much on the
specific implementation.)  This is as opposed to the
indirect binding models, where driver is expected to provide
first a description what it can do, and binding is done
after that, depending on the description provided.


Chaotic Model

This is not a specific model, but rather a lack of any model
that is designed in advance.  Self-made OS most often start
with it, and add a model on a later stage, when more drivers
appear.

Advantages:

The model itself requires no design efforts at all.

No fixed sets of functions to conform to.  Every coder is
free to implement whatever they like.

Unlimited upgradeability - a new super-hardware driver is
not bound by a lower common denominator.

Gives theoretically the best performance possible, as no
driver is bound to conform to anything but to the specific
hadrware abilities.

Disadvantages:

Upper layers can rely on nothing with it.  As more than one
driver for similar devices (eg.  sound cards) adds, upper
layers must check the present drivers for every single
function - which is actually implementing an in-built driver
model.  (Where its place is not, and therefore in a rather
clumsy way.)

Summary:

Good for homebrewn OS alikes, and for specific hardware that
is not subject to differencies, eg.  some mainframe that may
have only one type of NIC, VDC etc.  Otherwise, practically
unusable - the lack of driver systematics severely limits
the kernel internal flexibility.  Often upgraded with
functions that identify for each driver what it is capable
of, or requiring some (typically low) common denominator.


Common Denominator Model

With it, hardware drivers are separated in groups - eg.  NIC
drivers, sound drivers, IDE drivers.  Within a group, all
drivers export the same set of functions.

This set sometimes covers only the minimal set of
functionalities, shared by all hardware in the group - in
this case it acts as a smallest common denominator.  Other
possibility is a largest common denominator - to include
functions for all functionalities possible for the group,
and if the specific hardware doesn't support them directly,
to either emulate them, or to signal for an invalid
function.  Intermediate denominator levels are possible,
too.

The larger the common denominator, and the less emulation
("bad function" signal instead), the closer the model goes
to the chaotic model.

Advantages:

It requires little model design (esp.  the smallest common
denominator types), and as little driver design as possible.
(You may create an excellent design, of course, but you are
not required to.)  You can often re-use most of the design
of the other drivers in the group.

It practically doesn't require a plan, or coordination.  The
coder just tries either to give the functionality that is
logical (if this is the first driver in a new group), or
tries to give the same functionality that the other drivers
in the group give.

Coupling the driver to the upper levels that use it is very
simple and easy.  You practically don't need to check what
driver actually is down there.  You know what it can offer,
no matter the hardware, and don't need to check what the
denominator level ac ually is, unlike the chaotic model.

It encapsulates well the hardware groups, and fixes them to
a certain level of development.  This decreases the
frequency of the knowledge refresh for the programmers, and
to some extent the need for upper levels rewrite.

Disadvantages:

The common denominator denies to the upper level the exact
access to underlaying hardware functionality, and thus
decreases the performance.  With hardware that is below the
denominator line, you risk getting a lot of emulation, which
you potentially could avoid to a large degree on the upper
level (it is often better informed what exactly is desired).
With hardware above the denominator line, you may be denied
access to built-in, hardware-accelerated higher level
functions, that would increase performance and save you
doing everything in your code.

Once the denominator level is fixed, it is hard to move
without seriously impairing the backwards compatibility.
The hardware, however, advances, and offers built-in
upper-level functions and new abilities.  Thus, this model
quickly obsoletes its denominator levels (read:
performance and usability).

The larger the common denominator, the more design work the
model requires.  (And the quicker it obsoletes, given the
need to keep with the front.)

Summary:

This model is the opposite of the chaotic model.  It is
canned and predictable, but non-flexible and with generally
bad performance.  Model upgrades are often needed (and done
more rarely, at the expense of losing efficiency), and often
carry major rewrites of other code with them.


Discussion:

These two models are the opposites of the scale.  They are
rarely, if ever, used in clear form.  Most often, a driver
model will combine them to some extent, falling somewhere in
the middle.

The simplest combination is defining a (typically low)
common denominator, and going chaotic above.  While it
theoretically provides both full access to the hardware
abilities and something granted to base on, the granted is
little, and the full access is determinable like with the
chaotic model, in a complex way.

This combination also has some advantages:

Where more flexibility and performance is needed, you may go
closer to the chaotic model.  And where more replaceability
and predictability is needed, you may go closer to the CD
model.  The result will be a driver model that gives more
assets where they are really needed, and also has more
negatives, but in an area where they aren't that important.

If the optimum for a specific element, eg.  driver group,
shifts, you may always make the shift obvious.  Then, moving
the model balance for this element will be more readily
accepted by all affected by it.

Another way to combine the models is to break the big
denominator levels into multiple sublevels, and to provide a
way to describe the driver's sublevel, turning this model
into indirect binding type.

All this group of models, however, has a big drawback:
really good replaceability is provided only very close to
the common denominator end of the scale, where flexibiility,
performance, upgradeability and usability already tend to
suffer.  Skillful tuning may postpone the negatives to a
degree, but not forever.  Attempts to solve this problem are
made by developing driver models with indirect binding.


Indirect binding models:

With this model, drivers are expected to provide first a
description what they can do, and what they cannot.  Then,
the code that uses the driver binds to it, using the
description.

Most of these models take the many assets of the chaotic
model as a base, and try to add the good replaceability and
function set predictability of the common denominator model.


Class-like model

In it, the sets of functions that drivers offer are
organized in a class-like manner.  Every class has a defined
set of functions.  Classes create a hierarchy, like the
classes of OOP languages.  (Drivers do not necessarily have
to be written in an OO language, or to be accessed only
from such one.)  A class typically implements all functions
found in its predecessor, and adds more (but, unlike OOP
classes, rarely reuses predecessor code).

Classes and their sets of functions are pre-defined, but the
overall model is extendable without changing what is
present.  When a new type of device appears, or a new device
offers functionality above the current classes appropriate
for it, a new class may be defined.  The description of the
class is created, approved and registered (earlier stages
may be made by a driver writer, later - by a central body),
and is made available to the concerned.

Every driver has a mandatory set of functions that report
the driver class identification.  Using them, an upper layer
can quickly define what functionality is present.  After
this, the upper layer binds to the driver much like in the
direct binding models.

Advantages:

If properly implemented, gives practically the same
performance as the chaotic model.  Additional checking is
performed only once, when the driver is loaded.  Class
defining may be fine-grained enough to allow for practically
exact covering of the hardware functionality.

The upgradeability and usability of the specific drivers are
practically the same as those of the chaotic model.  And the
model global extendability and upgradeability, if properly
designed, are practically limitless.

If properly designed, gives nearly the same replaceability
as the CD model.  (The things to check are more, but much
less than with the chaotic model.  What you will find in
each of them is usually well documented.  And the check
procedure is standard and simple.)

Disadvantages:

The model itself requires more design and maintenance work
than the direct binding models (except the larger CD
models).  (Actually, the amount of maintenance work is the
same as with any CD model, but the work comes before the
need for it is felt by everybody.)

Discussion:

This is probably the best of all driver models I have
examined more carefully.  Unhappily, most implementations I
have seen are rather clumsy, to say the least.


Function map model

This model is actually a largest common denominator model,
extended with the ability to provide a map of the
implemented functions.  In the simplest case, the map is a
bitspace, where every bit marks whether its function is
implemented.  In other cases, the map is a space of accesses
(eg.  function pointers).

Advantages:

In some architectures and platforms, this is a very
convenient way to describe a function array.

The model is simple, and therefore easy to use.

Disadvantages:

The model has all disadvantages of a LCD model.

Discussion:

The advantages of the model are relatively little, while the
disadvantages are big.  For this reason, it is used mostly
as an addition to another model - eg.  to the class-like
model.


Global discussion:

The models list provided here is rather global, This is
intentional:  while designing, one must clarify one level at
a time, much like with coding.

The list also is incomplete.  For example, I never had the
time to look properly for ideas into the OS/2 SOM, and it is
said to work very well, and provide excellent performance.
Of interest might be also more details of the QNX driver
model.  Someone with in-depth knowledge of these might be
able to enhance this list.

----

