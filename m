Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132553AbRCZTWx>; Mon, 26 Mar 2001 14:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132550AbRCZTWo>; Mon, 26 Mar 2001 14:22:44 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:14344 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132553AbRCZTWa>;
	Mon, 26 Mar 2001 14:22:30 -0500
Date: Mon, 26 Mar 2001 14:24:58 -0500
Message-Id: <200103261924.f2QJOwL19694@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        trini@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML1 cleanup patch, take 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Progress is being made.  I submitted a cleanup patch in order to get rid
of three headaches before the 2.5 fork.  Three good things have since
happened since:

(1) Bjorn Wesen <bjorn@sparta.lu.se> informs me that the CRIS symbol bugs
    will be fixed in the next CRIS port update.  This will get rid of the
    single worst problem I was looking at.  (Somebody else pointed out that
    the present symbol names are invisible to `make dep'.)

(2) Greg Banks and Rik van Riel pointed out (separately) that I was too close 
    to the namespace problem; with a two-line change to my compiler I don't
    need to get numeric-prefix symbols cleaned up yet.  I think it's still
    a good  idea for the longer term, however, and a couple of the people
    who own those symbols have already endorsed changing them.

(3) The CONFIG_AIC7XXX_TAGGED_QUEUEING to CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT
    change that was on my buglist seems to have come out in the wash in the
    pre8 patch.

All that's left for me to do at this point, therefore, is fix the
PRINTER_READBACK glitch.  I will do my analysis tools on the assumption
that the CRIS symbols are going to be fixed.

This file is a patch expressed in two ways.  First, procedurally, as a
way to duplicate its effects on any kernel source tree.  Secondly, as
an explicit patch against 2.4.3-pre8.  It replaces my previous patches
against 2.4.3-pre6 and 2.4.3-pre8.

No actual object code will be changed by this patch.

For the procedural form, you will require the following Python 2.0 script
(note that this script has added anoption since my pre8 patch.):

-------------------------------- SCRIPT BEGINS HERE ---------------------------
#!/usr/bin/env python
#
# symbolreplace -- replace symbols in the current Linux source tree

import sys, os, re, getopt

renamings = {}	# Dictionary of translations
dobackup = 1
verbose = 0

#
# This is the only bit of knowledge in this script that knows anything
# about the lexical rules of the symbols we're looking for.  It's used as a
# guard expression on either side of each old symbol name -- matches
# must begin either with this guard or with a beginning-of-line, and end
# either with this guard or an end-of-line.  The purpose is to prevent false
# matches on FOO in FOOBAR and BARFOO.
#
guard = "[^A-Za-z0-9_]"

def backup(file):
    "Create a backup for the given file."
    # Compute where the RCS directory for this file should live.
    # Create it if necessary.
    rcs_dir = os.path.join(os.path.dirname(file), "RCS")
    if not os.path.exists(rcs_dir):
	os.mkdir(rcs_dir)

    # If there is no RCS master corresponding to the file, create one,
    rcs_file = os.path.join(rcs_dir, os.path.basename(file) + ",v")
    if not os.path.exists(rcs_file):
	os.system("ci -u -t- " + file + " >/dev/null 2>&1")

    # Check out a working copy if needed.
    if not os.access(file, os.W_OK):
	os.system("co -l " + file + " >/dev/null 2>&1")

def treevisit(root, visitor):
    "Apply the visitor function to every file under the given root path."
    def treewalker(hook, dirname, files):
        for file in files:
            here = os.path.join(dirname, file)
            if os.path.isfile(here) and here.find("RCS") == -1:
                hook(here)
    os.path.walk(root, treewalker, visitor)

def replacer(file):
    if verbose:
        print file

    # Suck the entire file into core as a list of lines.
    ifp = open(file, "r")
    contents = ifp.read()
    ifp.close()

    # Now perform the substitution on each line.
    substitutions = 0
    for pattern in renamings.keys():
        new_contents = pattern.sub(r"\1"+renamings[pattern]+r"\2", contents)
        if new_contents != contents:
            substitutions = substitutions + 1
            contents = new_contents

    # Spew the results.
    if substitutions:
        if dobackup:
            backup(file)
        ofp = open(file, "w")
        ofp.write(contents)
        ofp.close()

def guardify(old):
    "Turn the given symbol into a properly guarded regexp."
    return re.compile("(^|" + guard +")" + old + "(" + guard + "|$)")

def read_translations(fp):
    "Read translation requests from the given file object, ignoring comments."
    while 1:
        line = fp.readline()
        if not line:
            break
        elif line[0] == '#' or line[0] == '\n':
            continue
        else:
            (old, new) = line.split()
            renamings[guardify(old)] = new

# Main sequence

if __name__ == '__main__': 
    # Main sequence

    # Process options
    (options, arguments) = getopt.getopt(sys.argv[1:], "d:ns:v")
    topdir = "."
    for (switch, val) in options:
        if (switch == '-d'):		# Location of source tree if not .
            topdir = val
        elif (switch == '-n'):		# Suppress backups
            dobackup = 0
        elif (switch == '-s'):		# Do old:new substitution
            (old, new) = val.split(":")
            renamings[guardify(old)] = new
        elif (switch == '-v'):		# Report on files as they are processed
            verbose = 1

    if not renamings:
        read_translations(sys.stdin)
    treevisit(topdir, replacer)

# That's all, folks!
-------------------------------- SCRIPT ENDS HERE -----------------------------

Here is the instruction I used to generate the bulk of the patch.  A note on
the one manual change follows.

symbolreplace -v -d ~/src/linux -s CONFIG_PRINTER_READBACK:CONFIG_PARPORT_1284

After this, I manually removed the former PRINTER_READBACK entry in the
configuration-help file.

Finally, here is the generated patch:

--- Documentation/Configure.help	2001/03/26 18:15:21	1.1
+++ Documentation/Configure.help	2001/03/26 18:31:57
@@ -3724,12 +3724,6 @@
   This code is also available as a module (say M), called
   parport_mfc3.o. If in doubt, saying N is the safe plan.
 
-Support IEEE1284 status readback
-CONFIG_PRINTER_READBACK
-  If you have a device on your parallel port that support this
-  protocol, this option will allow the device to report its status. It
-  is safe to say Y.
-
 IEEE1284 transfer modes
 CONFIG_PARPORT_1284
   If you have a printer that supports status readback or device ID, or
--- Documentation/video4linux/CQcam.txt	2001/03/26 18:15:28	1.1
+++ Documentation/video4linux/CQcam.txt	2001/03/26 18:15:28
@@ -43,7 +43,7 @@
 
     CONFIG_PRINTER       M    for lp.o, parport.o parport_pc.o modules
     CONFIG_PNP_PARPORT   M for autoprobe.o IEEE1284 readback module
-    CONFIG_PRINTER_READBACK M for parport_probe.o IEEE1284 readback module
+    CONFIG_PARPORT_1284 M for parport_probe.o IEEE1284 readback module
     CONFIG_VIDEO_DEV     M    for videodev.o video4linux module
     CONFIG_VIDEO_CQCAM   M    for c-qcam.o  Color Quickcam module 
 
@@ -127,7 +127,7 @@
 
   The c-qcam is IEEE1284 compatible, so if you are using the proc file
 system (CONFIG_PROC_FS), the parallel printer support
-(CONFIG_PRINTER), the IEEE 1284 system,(CONFIG_PRINTER_READBACK), you
+(CONFIG_PRINTER), the IEEE 1284 system,(CONFIG_PARPORT_1284), you
 should be able to read some identification from your quickcam with
 
          modprobe -v parport
--- arch/m68k/config.in	2001/03/26 18:14:52	1.1
+++ arch/m68k/config.in	2001/03/26 18:14:52
@@ -140,7 +140,7 @@
    fi
    dep_tristate '  Parallel printer support' CONFIG_PRINTER $CONFIG_PARPORT
    if [ "$CONFIG_PRINTER" != "n" ]; then
-      bool '    Support IEEE1284 status readback' CONFIG_PRINTER_READBACK
+      bool '    Support IEEE1284 status readback' CONFIG_PARPORT_1284
    fi
 fi
 
End of patch.


-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

A ``decay in the social contract'' is detectable; there is a growing
feeling, particularly among middle-income taxpayers, that they are not
getting back, from society and government, their money's worth for
taxes paid. The tendency is for taxpayers to try to take more control
of their finances ..
	-- IRS Strategic Plan, (May 1984)
