Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286741AbRLVJFW>; Sat, 22 Dec 2001 04:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286739AbRLVJEZ>; Sat, 22 Dec 2001 04:04:25 -0500
Received: from fc.capaccess.org ([151.200.199.53]:34835 "EHLO fc.Capaccess.org")
	by vger.kernel.org with ESMTP id <S286735AbRLVJEB>;
	Sat, 22 Dec 2001 04:04:01 -0500
Message-id: <fc.008584120024d6cb008584120024d6cb.24d6f1@Capaccess.org>
Date: Sat, 22 Dec 2001 04:02:44 -0500
Subject: mockup of Linux schedule() in osimpa
To: linux-kernel@vger.kernel.org
Cc: linux-assembly@vger.kernel.org
From: "Rick A. Hohensee" <rickh@Capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"artist's impression" of Linux 1.2.13 schedule() in portable assembly

This is osimpa, formerly shasm, which doesn't have a linker in the
pertinent sense. This is basically legit osimpa, although not remotely a
working schedule(). The sense of some of the tests is probably wrong,
arguments to calls are probably not as per Gcc, various memrefs have
accidentally degenerated to constants, etc.. I suspect I could actually
build a Linux with a legit in-osimpa schedule() in it with the current
osimpa with some nm stunts, but the point here is what the code would look
like subjectively. I now have written enough osimpa to just sling some
mockup code. I should have built a Linux -Wa,-anhl and looked at the
assembly maybe. osimpa has reentrant procedures with locals and such. I
haven't bothered with such things here. There's also some struct-like
stuff in osimpa, which I also don't bother with here, except that the
struct element offsets are here presumed (pretended actually) to have
valid values already.

There's a lot of
                = $constant $reg to A
                                        in this. That's MOV struct->bla to
EAX where a register has previously been loaded with struct. I'm told most
RISCs, as well as the 386, can do that in one instruction, i.e. most RISCs
do have that addressing mode.

Rehashing a bit, this is a 100% useless bogosity of about the same
complexity and low-level-ness of Linux 1.2.13 schedule(). This is just a
visual impression. A working osimpa schedule() would and could look like
this subjectively. Linux schedule() is near-asm spaghetti that chafes
miserably under C, but most of the things fundamental kernel code needs to
be able to do are in evidence even in schedule(), and everything used here
is known to be working in pmode osimpa. A point that therefor remains is
that the x86-specificness is minor, and removeable. "BP" could easily be
"E", for example. Most of you should be able to see at a glance that the
code below, strange as it is, does not look CPU-specific. Nor does it have
any glaring machine word size dependancies. Note also that osimpa doesn't
have to be implemented using the sh parser, and might then look a bit less
scriptish.

Runtime performance would probably be similar to Gcc, and could surely be
as good. I did an osimpa-like Ackerman's function in m4/gas that was
noticeably better than Gcc (but noticeably worse than ocaml, which knows
ALL the recursion tricks), but I can't beat GNU grep for a literal string
in osimpa, so C is beatable when it's beatable, but C, even Gcc on x86,
can be unbeatable. The current osimpa in Bash is ludicrously slow to build
something, but a dedicated binary version or an m4/gas version would be
another matter, and should be more on the build-speed scale of Gas than
Gcc. Till then, building a whole Linux in osimpa in Bash would probably
heat up a Xeon pretty good for several hours, if not days.

So this is portable assembly, more or less, i.e. potentially portable
across commodity one-stack machines, i.e. the same target range as Gcc.
osimpa does have some composites, or "macros", that assemble more than one
instruction, but schedule() doesn't happen to use any. This is about the
same amount of text as the C version, so in the
instructions-per-typed-line sense C also is a portable assembler, and of
course actually is currently quite portable. This is C's great genius. It
was carefully designed to not compromise performance or flexibility much.
Other design aspects of C leave me less rapturous. The leap to abstraction
of high-level languages was of noble enough intent, but has not panned out
much that I can see. Most of the things that make programming easier are
stylistic, and available to an assembler designed accordingly, like lucid
verbose names or terseness as appropriate, clear indenting and so on.

Some branches are a couple lines of code in osimpa and only one in C, but
that's a nebulous distinction. I don't do IF/ELSE, FOR loops and so on in
osimpa, whereas e.g. Randy Hyde's HLA does have such things. "Structured
programming" is not a panacea, was tossed out in Linux schedule() in C,
and abstraction is often ambiguous. Plain branches may tend to spaghetti,
but they are individually unambiguous. Structured programming is a
miscarriage of proper factoring. Proper factoring is the key, although I
haven't factored schedule().

I don't think C is much easier to learn or to code than a modernized
assembler, particularly for kernel code that is going to need to escape or
link to assembly anyway. I believe this is the point at which osimpa may
even be advantageous versus C etc.. osimpa doesn't have asm("") issues.
The lack of "pointers" is just gravy.

ftp://linux01.gwdg.de/pub/cLIeNUX/interim/osimpa.tgz

Happy Chanukwanzamas

Rick Hohensee
cLIeNUX User 0

#.......................................................................

L schedule              # no args in or out. The registers are ours.

p=DI    c=SI    ticks=BP        next=D          # locals in registers
                                                # I think this scopes
= $tq_scheduler to A
 call run_task_queue            # I'm assuming run_task_queue returns
"void"
nointerrupts
        = @ $itimer_ticks to $ticks
        = 0 to  $itimer_ticks
        = -1 to $itimer_next
interrupts
= 0 to  $need_resched
= 0 to  $nr_running
=  $init_task to $p
  L per_task
        = $p $next_task to $p
        -test $init_task to $p
                when    zero                    didtasks
        = $it_real_value $p to A
        ANDtest $ticks to A
                when    not     zero            didtasks
                -test $ticks to A
                        when    sign            end_itimer
                        = $SIGALRM to A
                        = $p to B
                        = 1 to C
                         call send_sig
                        = $it_real_incr $p to A
                        flag A
                                when    zero    scheduleL2
                                        = 0 to $it_real_value $p
                                        jump    end_itimer
    L scheduleL2
                = $p $it_real_value to A
                - $it_real_incr $p to A
                = A to $p $it_real_value
                -test $ticks to A
                        when    sign            scheduleL2
                - $ticks to A
                = A to $p $it_real_value
                -test @ $itimer_next to A
                        when    sign            end_itimer
                = A to @ $itimer_next
   L end_itimer
                -test $TASK_INTERRUPTIBLE to $state $p
                        when    not     zero    per_task
                = $signal $p to A
                ANDtest $blocked $p to A
                        when    not     zero    per_task
                = $TASK_RUNNING to $p $state
   L scheduleL4
                = $timeout $p to A
                flag A
                        when    zero    didtasks
                -test $jiffies to A
                        when    sign    didtasks
                        = 0 to $timeout $p
                        = $TASK_RUNNING tp $state $p
  L didtasks
        = -1000 to c
        = $init_task to $p
        = $init_task to $next
  L per_task2
        = $p $next_task to $p
        -test $init_task to $p
                when    zero                    didtasks2
        = $state $p to A
        -test $TASK_RUNNING to A
                when    not     zero    twarntrunnin
                1+ @ $nr_running
                -test $counter $p to $c
                        when    not     sign    twarntrunnin
                        = $counter $p to $c
                        = $next to $p
  L twarntrunnin
        jump                                            per_task2
  L didtasks2
        flag $c
                when    not     zero    schedule_foreachtaskpre
        = $init_task to $p
  L schedule_foreachtaskpre
        = @ $init_task to $p
  L schedule_for_each_task
        = $p $next_task to $p
        -test @ $init_task to $p
                when    zero            doneschedule_for_each_task
                = $counter $p to A
                downshift 1 to A
                + $priority $p to A
                = A to $counter $p
        jump schedule_for_each_task
  L doneschedule_for_each_task
= @ $current to A
-test $next to A
        when    not     zero    OKswitch
                return
  L OKswitch
1+ @ $(($kstat+$context_swtch))
= $next to A
 call switch_to                         # or is this a jump?

# end of schedule

