Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWFUDqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWFUDqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 23:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWFUDqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 23:46:18 -0400
Received: from xenotime.net ([66.160.160.81]:40416 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750753AbWFUDqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 23:46:17 -0400
Date: Tue, 20 Jun 2006 20:49:03 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 20/20 RFC] chardev: GPIO for SCx200 & PC-8736x: add
 sysfs-GPIO interface
Message-Id: <20060620204903.af2a5805.rdunlap@xenotime.net>
In-Reply-To: <44944D14.2000308@gmail.com>
References: <448DB57F.2050006@gmail.com>
	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
	<44944D14.2000308@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 12:42:28 -0600 Jim Cromie wrote:

> Ok, 
> heres the brand-spanking-new proto-sysfs-gpio interface,
> preceded by some pseudo/proto-Documentation.
> 
> 
> We need a standard rep for GPIO in sysfs, so heres a strawman.
> Strike a match, lets have a campfire!
> 
> Essentially, this seeks to describe the directory of
> 'device-attribute-files' that are populated by a driver
> 
> All device-attr-files are named as <prefix>_<id>_<suffix>
> 
> in LM-sensors:
> - prefix        sensor-type: in(volts), temp, fan, etc. (no trailing '_')
> - id            usually single integer
> - suffix        the sensor attribute in question.
> 
> 
> GPIO-sysfs Prefix Names.
> 
> Basically, GPIO hardware design appears to have 2 top-level factors;
> pin features, and pin-to-port grouping.  These are mapped onto
> filename prefixes & suffixes.
> 
> All GPIOs (Ive seen) are organized as 1+ ports of 8-32 bits.  The
> bits' attributes are addressable individually, but are also accessible
> as a group via the port_* files.  If you change a bit-attribute, that
> change will also exhibit in the port attr too.

Drop one of "also" and "too".  (redundant)

> IOW, we have bit_*, port_*.  They are interconnected at the hardware
> level, and (I think) there is no need for inter-locks between the
> sysfs handlers for bit_ and port_ (except for shadow regs, but I
> digress)

add period ('.')

> In fact, it might be nice to have the option of not creating the bit_*
> sysfs-device-files.  For apps where user-code is doing its own
> bit-masking, the kernel could avoid some unused overheads.  OTOH, this
> might be silly, premature, overoptimization.  This would be controlled
> - assuming its worthwhile - by a modparam; 'nobits' or 'portsonly'
> 
> 
> GPIO Architectures
> 
> GPIO pins have lots of hardware / architectural / naming-convention
> variations, which makes this harder.  My simplifying assumption is
> that drivers should reflect the hardware capabilities directly (or
> very nearly so), and push the abstraction to user-space (at least in
> part).  Obviously this needs

needs completing....

> Drivers should create sysfs 'files' only for attributes that are
> pertinent for the hardware being driven.  Ths way, the absense or
s/Ths/This/
s/absense/absence/

> presense of files communicates functionality, as does their
s/presense/presence/

> readonlyness.  (these 'behaviors' may be different than lm-sensors)

read-only-ness IMO.
s/these/These/
s/than/from/
add a period at end.

> Forex:

Use "For example:" or "E.g.:".

> if a pin is input  only, it shouldnt have an _output_enabled attr.
> if a pin is output only, it shouldnt have an _output_enabled attr.

s/output_enabled/input_enabled/

> This way, `ls` tells you that a particular port/bit cannot possibly
> drive a value out of the chip.
> 
> - one of several different values (otherwize why show it ?
>   After all, you dont to be told that PI=3.14159...)

Some lines were rearranged ??

> - changed.  if a pin cannot be output, theres nothing to enable, and
>   showing the attribute is confusing.
> 
> OTOH, a readonly _output_enabled would also convey info.

Confusing lines...

> yield the same, but not as
> visibly (ls vs ls -l)
> 
> So, Im somewhat ambivalent here, looking for input....

You are doing pretty well here, with the exception of the
aversion to tic marks.

> User-Space
> 
> Following LM-sensors approach, a user-side library would add the
> niceties:
> 
> - provide any equivalences needed by users
>   ie bit_x_tristate = ! bit_x_output_enabled.

I strongly prefer "i.e." to "ie".

> - sub-port allocation and management.
>   support for 3+3+2 bit sub-ports on an 8 bit port would be nice
> 
> I suspect that a sophisticated programmer would be able to add a
> sub-port allocation facility w/in the driver.  I cannot,

s/,/./

> GPIO Pin Features
> 
> As outlined above, pin features are represented as _<suffixes>
> 
> 1st: there are several alternative naming schemes:
> 
> - name-as-verb          _output_enable          (conveys an 'action')
> - name-as-state         _output_enabled         (conveys a 'current state')
> - feature-name          _output                 (a knob to turn)
> - feature+state         _output+(currval)       (currval in name is bad idea)
> 
> 1,2 are quite close.  Ive done 2.

I can't tell which choices above are 1, 2, etc.

> FWIW, heres the pin attributes of my GPIOs, as expressed in the syslog
> by the legacy drivers: (these are

??

> [15510.384000]  pc8736x_gpio.0: io16: 0x0004 TS OD PUE  EDGE LO         io:0/1
> [15510.564000]  pc8736x_gpio.0: io17: 0x0004 TS OD PUE  EDGE LO         io:1/1
> [15510.744000]  pc8736x_gpio.0: io18: 0x0004 TS OD PUE  EDGE LO         io:1/1
> [15510.928000]  pc8736x_gpio.0: io19: 0x0004 TS OD PUE  EDGE LO         io:1/1

More confusing interspersed lines.

> # whether output-drive is on/off
> _output_enable          # 1 or 0,
> _tristate               # ! _output_enable, logically linked.
> 
> Now, theres no need to have both of these; if there were, they would
> have to be intrinsically linked (logically opposite values).
> 
> IOW, drivers should name the file as one of possible states of the
> feature, which ever best describes it, and not expose it 2x.
> 
> To the extent that we need support for '_tristate' version of a
> '_output_enabled' sysfs-file, user-space (libraries) should provide
> that support.
> 
> # output circuit configuration
> _opendrain              # only 1 transistor, can sink current from pin
> _totem                  # has 2nd transistor, can drive pin hi.
> _pushpull               # alias for _totempole
> 
> Ive chosen _totem as the attribute name
> 
> _pullup_enabled         # pin tied to power via resistor.
> _pullup_off             # duh
> _pullup_no              # how many aliases ?
> 
> _debounce               # present if supported, 0 if off, 1 if on.
> 
> It kinda works, but the pullup is a bit ugly, and all the aliases
> suggest some semantic difficulty/mismatch/incompleteness, but adding
> them all definitely creates clutter and has reached diminished
> incremental value.
> 
> 
> If hardware doesnt support a feature, like _opendrain, it:
> 
>  - sets _pushpull to 1, readonly ?
>  - sets _opendrain to 0, readonly ?
>     OR never creates _opendrain ?
> 
> Doing either of these works to communicate the feature-set to
> user-space, but not creating _opendrain when pin doesnt do it means
> that the file's presense communicates this; IOW, user issues 'ls', not

s/presense/presence/

> 'ls -l' to find out.
> 
> (continuing strawman)
> 
> _value          # read the pin
> (no-suffix)     # alias for _value
> 
> _current        # the value 'driven' by the pin (last written)
> 
> And here we can see some potential (user) difficulties;
> under some conditions,
> - read-value = current-value
> 
> but not on these:
> - pin is input-only/tristate - (current is irrelevant, except as 'state')
> - pin is over-driven by attached circuit
> -- pin cannot sink/supply sufficient current
> 
> Detecting these situations is both hardware and circuit dependent, and
> properly belongs in user-space.  It sounds a lot like what lm-sensors
> does already.
> 
> For the 2 drivers Ive 'experienced', pin control was via device-file,
> with this command-set.  Presumably the correspondence with the sysfs
> strawman above is obvious.
> 
> case 'O':        output enabled
> case 'o':        output disabled
> case 'T':        output is push pull
> case 't':        output is open drain
> case 'P':        pull up enabled
> case 'p':        pull up disabled
> 
> 
> Port Organization.
> 
> My *vast* experience (with 1.5 GPIO architectures) suggests that all
> chips organize their GPIOs into one or more ports.  Each port supports
> reading and writing all bits simultaneously.
> 
> Some hardware also supports reading/writing pin-properties like
> output-enable in a single-word (todo-research).  Drivers for these
> hardwares could/should create attributes for each pin-property that is
> accessible as a bit-vector.
> 
> Further, port (and pin) capabilities generally vary by port; hardware
> will typically put a full set of features on 1 port, and less on
> others, expecting a designer to allocate functions to pins
> accordingly.  Forex, on the pc8736x chip, port 0 can issue interrupts,

not "Forex".

> so those pins should have extra properties.
> 
> These capabilities must be cleanly representable in any worthwhile
> sysfs/GPIO model (and we continue to test this strawman)..
> 
> 
> Port-names and Pin-names
> 
> # prefixes (note the trailing _)
> port_[0..P]_
> bit_[P]_[0..bits-per-word]_
> 
> Getting past the port/bit names, these files are populated by the
> driver according to the device.  For the 2 drivers Ive touched, heres
> the table:
> 
> driver:         ports   bits-per-port
> scx200_gpio     1       32
> pc8736x_gpio    4       8
> 
> 
> Strawman tie-together:
> 
> bit_0_0_output_enable   # shows current output-drive of port 0 bit 0
> bit_0_0_value
> bit_0_0                 # 2 reads of same bit
> 
> # lessee what happens :->

Let's see ...

> port_0_value_bin        # 1-4 bytes typically returned (depending on device)
> port_0_value_hex        # converted to human readable, always printable
> port_0_value            #
> 
> port_1_output_enable    # read/write vector of enable bits to port
> port_1_<suffix_set>     #
> 
> 
> The driver should know which properties are readable/writable in a
> bit-vector basis, and expose those sysfs-attributes only.  Thus the
> presense of the port_N_value* attrs implies that all the bits in that
> port are readable at once.
> 
> If the driver doesnt expose forex: port_1_output_enable, user-space is

s/forex/e.g./

> free to loop over each bit, in essence 'emulating' the port-wide
> operation.
> 
> 
> RESTATING - whats above kinda hangs together.
> 
> NEXT - muddles
> 
> pin_XY_output_state     # one-of( 'output_enable', 'tristate')
> 
> This might be convenient for some situations, but probably is needless
> complication / obfuscation.
> 
> 
> pin_XY_state_bin                # binary state reader
> 
> This is intended an 'escape-valve' for things that are turn out to be

s/an/as an/
s/that are/that/

> cumbersome with the above.  This is probably tantamount to an IOCTL,
> so might be a hugely bad idea.
> 
> 
> pin_XY_interrupt_enable        #
> pin_XY_interrupt_trigger_edge
> pin_XY_interrupt_trigger_level
> pin_XY_interrupt_trigger_edge_rising
> pin_XY_interrupt_trigger_edge_falling
> pin_XY_interrupt_trigger_level_hi
> pin_XY_interrupt_trigger_level_lo
> 
> Well - thats a big one - Do we expose any of this ?
> - the ability to enable / disable / control hardware interrupt
> - or is that insane meddling in such affairs ?
> 
> We cant afterall allow mapping of the actual interrupt handler, that
> does sound insane (unless hugely carefull)

s/carefull/careful/

> With the new genirq architecture, things are apparently more
> orthogonal, which suggests there might be something to control by
> means of attributes such as above.
> 
> Further, any of the above attributes could readily be RO; they would
> convey info thats at least useful, even if 'control' is too exposing.
> 
> Forex, somewhere during boot, the APIC is setup to handle interrupts;

s/Forex/E.g./

> at this point its probably known what the configured state of all
> interrrupts is, and this info could be exposed here.  Whether that has
> sufficient value is unclear, and certainly not for v.submit-1
> 
> 
> when a pin is level-triggered (presumably this can be
> determined early in the boot process, as soon as APIC etc would be
> 

eh?

> 
> setup), the _edge_* attributes vanish, and the _level_{hi,lo} attrs
> are set 1/0, and RO.
> 
> 
> OK - IM DONE.
> 
> Please be liberal with feedback -
> - this is wrong
> - poorly explained -
> - correct ... - boil this down - reduce to a guiding statement
> - strip out conjectures

I can't tell which parts of this are the documented interface
and which parts are you just thinking in bits/bytes, so I made
corrections to all of it...

I would say that you need to make a proposal and see what feedback
(if any) you get on it.

And I'm not in the right group of people to tell you how GPIO
pins should be represented.


[deleted some source files]

---
~Randy
