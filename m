Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289972AbSBKSMS>; Mon, 11 Feb 2002 13:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289918AbSBKSMK>; Mon, 11 Feb 2002 13:12:10 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:34190 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289972AbSBKSL6>; Mon, 11 Feb 2002 13:11:58 -0500
Date: Mon, 11 Feb 2002 13:12:53 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lse-tecg@lists.sourceforge.net, davej@suse.de, marcelo@conectiva.com.br
Subject: GCOV Support for Linux (including dynamic modules)
Message-ID: <20020211131253.A1468@elinux01.watson.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is <gcov.tar.bz2> implementing this functionality for
the 2.4.17 and the 2.5.2 kernels.


GCOV kernel support for Linux
=============================

What is GCOV?
-------------
gcov is a test coverage program, which helps discover where your 
optimization efforts will best affect your code. Using gcov one can find 
out some basic performance statistics on a per source file level such as:
        * how often each line of code executes
        * what lines of code are actually executed
        * how much computing time each section of code uses


What we implemented?
--------------------
gcov is already available for user level applications. 
We implemented gcov support for the linux kernel by providing
coverage support infrastructure to the kernel and a dynamic
module (gcov.o) to produce the basic block profile information, 
which gives the statistics for the running kernel and modules. 


Installing GCOV support on the kernel
-------------------------------------
To provide the coverage support infrastructure to the kernel,
install the gcov patch 
(2.5.2-gcov-kernel.patch OR 2.4.17-gcov-kernel.patch) from the root
level of the kernel source path, as

        patch -p1< {path}/2.5.2-gcov-kernel.patch

Configuring the kernel
----------------------

To configure the entire kernel for gcov profiling, run
        make xconfig or menuconfig

There are two options under GCOV coverage profiling. They are
        * enable GCOV kernel
        * GCOV kernel profiler

"enable GCOV kernel" will provide the infrastructure of 
coverage support for the kernel. 
But this will not compile the kernel with the necessary flags. 

To obtain the coverage information for the entire kernel, one should
enable the "GCOV kernel profiler" option. 

To get the profiling information for a particular file or directory of
the kernel, provide the following compile options for such targets 
itself, like

        CLAGS += ($CFLAGS $GCOV_FLAGS)

where GCOV_FLAGS is "-fprofile-arcs -ftest-coverage"

and compile the kernel. 

Accessing GCOV information
--------------------------
In order to produce the profiling information, compile and install the
gcov.o module as follows (ensure that the proper linux include path is
provided in the Makefile)

        make 
        insmod gcov.o

and to remove the module, run

        rmmod gcov

The detailed explanation of how gcov provides the statistics
information is described below.

How it works?
-------------

Here is the brief explanation of how gcov works for user level
applications.

The C compiler supports the command line options -fprofile-arcs and
-ftest-coverage. These options cause the compiler to insert additional
code in the object files. These options also generate two files
(a) <sourcefile>.bb and (b) <sourcefile>.bbg, where 
        * .bb file contains a list of source files (including headers), 
functions within those files and line numbers corresponding to each 
basic block in the source file.
        * .bbg file contains a list of the program flow arcs for each
function which in combination with the .bb file enables gcov to 
reconstruct the program flow.

Upon executing a gcov enabled user program, it dumps the counter
information into <sourcefile>.da at the time of exit.

Running gcov with the program's source file name as argument, will combine the
information from .bb, .bbg and .da files and produce a listing of the code 
along with the frequency of execution of each line. 

For further detailed information, refer gcov.readme which is the text
form of gcc/doc/gcov.texi from the GCC source code.

How gcov works for kernel
-------------------------

As the kernel never does exit as a program, this cannot be deployed in such a
fashion. The .da file is made available under /proc/gcov/{kernel source path}.

For example:
Consider a file ./kernel/sched.c. After compiling this file, the
compiler will generate .bb and .bbg file and it will be in the directory
where the source code is located. ie. ./kernel/sched.bb and ./kernel/sched.bbg.

Installing the gcov kernel module will create a file at 
/proc/gcov/kernel/sched.da and create symbolic links for the files
 ./kernel/sched.c, ./kernel/sched.bb and ./kernel/sched.bbg to
/proc/gcov. We opted for providing these links in order to allow usage
of an unmodified gcov tool.

Finally there will be 4 files under /proc ie.

/proc/gcov/kernel/sched.c
/proc/gcov/kernel/sched.bb
/proc/gcov/kernel/sched.bbg
/proc/gcov/kernel/sched.da

This is the same for all the files which are built with the gcov 
options(-fprofile-arcs and -ftest-coverage).

Now to see the statistics information for the sched.c, run gcov
from any of your local directory as follows:

        gcov -o /proc/gcov/kernel /proc/gcov/kernel/sched.c

This will generate results in the local directory as sched.c.gcov.

Here is a sample output from the signal.c.gcov file

                static void handle_stop_signal(int sig, struct task_struct *t)
                {
        8392            switch (sig) {
           7            case SIGKILL: case SIGCONT:
                                /* Wake up the process if stopped.  */
           7                    if (t->state == TASK_STOPPED)
      ######                            wake_up_process(t);
           7                    t->exit_code = 0;
           7                    rm_sig_from_queue(SIGSTOP, t);
           7                    rm_sig_from_queue(SIGTSTP, t);
           7                    rm_sig_from_queue(SIGTTOU, t);
           7                    rm_sig_from_queue(SIGTTIN, t);
        8385                    break;
 
                        case SIGSTOP: case SIGTSTP:
                        case SIGTTIN: case SIGTTOU:
                                /* If we're stopping again, cancel SIGCONT */
      ######                    rm_sig_from_queue(SIGCONT, t);
        8385                    break;
        8385            }
                }

where "######" represents no execution.

Here are the various arguments for invoking gcov

     gcov [-b] [-c] [-v] [-n] [-l] [-f] [-o directory] SOURCEFILE
 
-b
     Write branch frequencies to the output file, and write branch
     summary info to the standard output.  This option allows you to
     see how often each branch in your program was taken.
 
-c
     Write branch frequencies as the number of branches taken, rather
     than the percentage of branches taken.
 
-v
     Display the `gcov' version number (on the standard error stream).
 
-n
     Do not create the `gcov' output file.
 
-l
     Create long file names for included source files.  For example, if
     the header file `x.h' contains code, and was included in the file
     `a.c', then running `gcov' on the file `a.c' will produce an
     output file called `a.c.x.h.gcov' instead of `x.h.gcov'.  This can
     be useful if `x.h' is included in multiple source files.
 
-f
     Output summaries for each function in addition to the file level
     summary.
 
-o
     The directory where the object files live.  Gcov will search for
     `.bb', `.bbg', and `.da' files in this directory.           


How gcov works for dynamic modules
----------------------------------

For dynamic modules, once the module gets installed all these files 
(.bb, .bbg, .da) will be created dynamically under 
"/proc/gcov/module/{module source path}". Similarly their proc entries 
will be eliminated when the module gets removed.

To get the coverage information for dynamic modules, one must install
our 2.4.12-insmod.patch to the insmod code which will be in modutils 
package.  This modutils source file can be downloaded from 

http://www.kernel.org/pub/linux/utils/kernel/modutils/v2.4

This patch should be applied from the modutils source directory as
	patch -p1 < 2.4.12-insmod.patch

and proceed with the instructions in the "INSTALL" file at the 
modutils root directory.


Resetting the counters:
----------------------
        One can dynamically reset the counters of the file, by writing "0" 
to the required .da file.

For example, if you want to reset the counters in sched.c then executing
the command

        echo "0">/proc/gcov/kernel/sched.da

will reset the counters.


There is a /proc/gcov/vmlinux file which holds the block information
of all the files compiled with gcov options.

cmd> echo "0">/proc/gcov/vmlinux

will reset all the counters in the kernel.

cmd> cat /proc/gcov/vmlinux 

dumps the entire block informantion for all files in the following format

filename-len (8bytes)
filename     (8bytes aligned)
nounts       (8bytes)
counter[0..ncounts-1]   (each 8bytes)

We have not written any user level program to utilize the vmlinux file.


Tested Environment
------------------
We have tested this on RedHat 7.0 and 7.2 under gcc versions 2.91.66 and 
3.0.3. 

Problems
--------
gcc does not provide atomic operations for statistics counters. This needs to 
be supported in gcc. As a result counters value MAY be overwritten and hence 
produce inaccurate results.


-- Hubertus Franke


--liOOAslEiF7prFVr
Content-Type: application/x-bzip2
Content-Disposition: attachment; filename="gcov.tar.bz2"
Content-Transfer-Encoding: base64

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

--liOOAslEiF7prFVr--
