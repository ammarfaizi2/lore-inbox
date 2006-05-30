Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWE3WFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWE3WFg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWE3WFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:05:36 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:44437 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S932520AbWE3WFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:05:35 -0400
Message-ID: <447CC19D.4020603@vilain.net>
Date: Wed, 31 May 2006 10:05:17 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>,
       Herbert Poetzl <herbert@13thfloor.at>, Kirill Korotaev <dev@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <1148630661.7589.65.camel@homer> <20060526161148.GA23680@atjola.homenet> <447A2853.2080901@vilain.net> <447A3292.5070606@bigpond.net.au> <447A65EA.9020705@vilain.net> <447A6D7B.9090302@bigpond.net.au> <447B64BF.4050806@vilain.net> <447B7FD6.6020405@bigpond.net.au> <447BA8ED.3080904@vilain.net> <447BB1C6.9050901@bigpond.net.au>
In-Reply-To: <447BB1C6.9050901@bigpond.net.au>
X-Enigmail-Version: 0.92.1.0
Content-Type: multipart/mixed;
 boundary="------------090801040700080307040104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090801040700080307040104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Peter Williams wrote:

>They shouldn't interfere as which scheduler to use is a boot time 
>selection and only one scheduler is in force.  It's mainly a coding 
>matter and in particular whether the "scheduler driver" interface would 
>need to be modified or whether your scheduler can be implemented using 
>the current interface.
>  
>

Yes, that's the key issue I think - the interface now has more inputs.

>>I guess the big question is - is there a corresponding concept in
>>> PlugSched?  for instance, is there a reference in the task_struct to the
>>> current scheduling domain, or is it more CKRM-style with classification
>>> modules?
>>    
>>
> It uses the standard run queue structure with per scheduler
> modifications (via a union) to handle the different ways that the
> schedulers manage priority arrays (so yes). As I said it restricts
> itself to scheduling matters within each run queue and leaves the
> wider aspects to the normal code.


Ok, so there is no existing "classification" abstraction?  The
classification is tied to the scheduler implementation?

>At first guess, it sounds like adding your scheduler could be as simple 
>as taking a copy of ingosched.c (which is the implementation of the 
>standard scheduler within PlugSched) and then making your modifications. 
>  You could probably even share the same run queue components but 
>there's nothing to stop you adding new ones.
>
>Each scheduler can also have its own per task data via a union in the 
>task struct.
>  
>

Ok, sounds like that problem is solved - just the classification one
remaining.

>OK.  I'm waiting for the next -mm kernel before I make the next release.
>  
>

Looking forward to it.

>>Now, forgive me if I'm preaching to the vicar here, but have you tried
>>using Stacked Git for the patch development?
>>    
>>
>
>No, I actually use the gquilt GUI wrapper for quilt 
><http://freshmeat.net/projects/gquilt/> and, although I've modified it 
>to use a generic interface to the underlying patch management system 
>(a.k.a. back end), I haven't yet modified it to use Stacked GIT as a 
>back end.  I have thought about it and it was the primary motivation for 
>adding the generic interface but I ran out of enthusiasm.
>  
>

Hmm, guess the vicar disclaimer was a good one to make.

Well maybe you'll find the attached file motivating, then.

Sam.

--------------090801040700080307040104
Content-Type: text/x-python;
 name="gquilt_stgit.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gquilt_stgit.py"

# -*- python -*-

### Copyright (C) 2006 Sam Vilain <sam.vilain@catalyst.net.nz>

### based on gquilt_quilt.py, which is:
### Copyright (C) 2005 Peter Williams <pwil3058@bigpond.net.au>

### This program is free software; you can redistribute it and/or modify
### it under the terms of the GNU General Public License as published by
### the Free Software Foundation; version 2 of the License only.

### This program is distributed in the hope that it will be useful,
### but WITHOUT ANY WARRANTY; without even the implied warranty of
### MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
### GNU General Public License for more details.

### You should have received a copy of the GNU General Public License
### along with this program; if not, write to the Free Software
### Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

# This file provides access to "stgit" functionality required by "gquilt"

import gquilt_utils, os.path, os, gquilt_tool, gquilt_pfuns, re

class stgit_commands(gquilt_utils.cmd_list):
    def __init__(self):
        gquilt_utils.cmd_list.__init__(self)
    def _get_commands(self):
        res, sop, eop = gquilt_utils.run_cmd("stg --help")
        if sop == "":
            return None
        lines = sop.splitlines()
        index = 0
        found = 0
        cmds = []
        while True:
            if found:
              lcmds = lines[index].split()
              cmds.push(lcmds[0])
            else:
              if lines[index].match("commands:"):
                found = 1
            index += 1
        
        cmds.sort()
        return cmds

# run a command and log the result to the provided console
def _exec_console_cmd(console, cmd, error=gquilt_tool.ERROR):
    res, so, se = gquilt_utils.run_cmd(cmd)
    if console is not None:
        console.log_cmd(cmd + "\n", so, se)
    if res != 0:
        return (error, so, se)
    else:
        return (gquilt_tool.OK, so, se)

def _patch_file_name(patch):
    # FIXME - cache this
    res, so, se = gquilt_utils.run_cmd("stg branch")
    branch = so.strip()
    return ".git/patches/" + branch + "/patches/" + patch + "/description"

# Now implement the tool interface for quilt
class interface(gquilt_tool.interface):
    def __init__(self):
        gquilt_tool.interface.__init__(self, "stgit")

    def is_patch_applied(self, patch):
        res, so, se = gquilt_utils.run_cmd("stg applied")
        lines = so.splitlines()
        index = 0
        while lines[index]:
            lines[index].strip()
            if lines[index] == patch:
                return 1
        return 0
    
    def top_patch(self):
        res, so, se = gquilt_utils.run_cmd("stg top")
        if res == 0 or (se.strip() == "" and so.strip() == ""):
            return so.strip()
        elif res == 512 and so.strip() == "":
            return ""
        else:
            raise "stgit_specific_error", se

    def last_patch_in_series(self):
        res, op, err = gquilt_utils.run_cmd("stg series -s")
        if res != 0:
            raise "stgit_specific_error", se
        lastline = op.splitlines()[-1]
        return lastline.match(". (.*)")[1]

    def display_file_diff_in_viewer(self, viewer, file, patch=None):
        # XXX - not a good enough abstraction for stg.
        return

    def get_patch_description(self, patch):
        pfn = _patch_file_name(patch)
        if os.path.exists(pfn):
            res, lines = gquilt_pfuns.get_patch_descr_lines(pfn)
            if res:
                return (gquilt_tool.OK, "\n".join(lines) + "\n", "")
            else:
                return (gquilt_tool.ERROR, "", "Error reading patch description\n")
        else:
            return (gquilt_tool.OK, "", "")

    def get_patch_status(self, patch):
        # XXX - not sure what the "needs refresh" stuff was about
        if self.is_patch_applied(patch):
            return (gquilt_tool.OK, gquilt_tool.APPLIED, "")
        else:
            return (gquilt_tool.OK, gquilt_tool.NOT_APPLIED, "")

    def get_series(self):
        res, op, err = gquilt_utils.run_cmd("stg branch")
        patch_dir = op.strip()
        res, op, err = gquilt_utils.run_cmd("stg series")
        if res != 0:
            return (gquilt_tool.ERROR, (None, None), err)
        series = []
        for line in op.splitlines():
            if line[0] == "-":
                series.append((line[2:], gquilt_tool.NOT_APPLIED))
            else:
                pn = line[2:]
                #res, status, err = self.get_patch_status(pn)
                #series.append((pn, status))
                series.append((pn, gquilt_tool.APPLIED))
        return (gquilt_tool.OK, (patch_dir, series), "")

    def get_diff(self, filelist=[], patch=None):
        if patch is None:
            cmd = "stg diff -r /bottom"
        else:
            cmd = "stg diff -r " + patch + "/bottom:" + patch
        res, so, se = gquilt_utils.run_cmd(" ".join([cmd, " ".join(filelist)]))
        if res != 0:
            return (gquilt_tool.ERROR, so, se)
        return (res, so, se)

    def get_combined_diff(self, start_patch=None, end_patch=None):
        cmd = "stg diff -r "
        if start_patch is None:
            cmd += "base"
        else:
            cmd += start_patch+"/bottom"
        if end_patch is not None:
            cmd += ":" + end_patch
        res, so, se = gquilt_utils.run_cmd(cmd)
        if res != 0:
            return (gquilt_tool.ERROR, so, se)
        return (res, so, se)

    def get_patch_files(self, patch=None, withstatus=True):
        if self.top_patch() == "":
            return (gquilt_tool.OK, "", "")
        cmd = "stg files"
        if not withstatus:
            cmd += " --bare"
        if patch is not None:
            cmd += " " + patch
        res, so, se = gquilt_utils.run_cmd(cmd)
        if res != 0:
            return (gquilt_tool.ERROR, so, se)
        if withstatus:
            filelist = []
            for line in so.splitlines():
                if line[0] == "A":
                    filelist.append((line[2:], gquilt_tool.ADDED))
                elif line[0] == "D":
                    filelist.append((line[2:], gquilt_tool.DELETED))
                else:
                    filelist.append((line[2:], gquilt_tool.EXTANT))
        else:
            filelist = so.splitlines()
        return (res, filelist, se)

    def do_set_patch_description(self, console, patch, description):

        if patch != self.top_patch:
            return ( gquilt_tool.ERROR, "", "Can only edit top patch description")

        # FIXME shellquote properly
        cmd = "stg refresh -m '" + description + "'"
        res, so, se = gquilt_utils.run_cmd(cmd)
        if res == 0:
            res = gquilt_tool.OK
            se = ""
        else:
            res = gquilt_tool.ERROR
            se = "Error reading patch description\n"

        if console is not None:
            console.log_cmd('set description for "' + patch + '"', "\n", se)

        return (res, "", se)

    def do_rename_patch(self, console, patch, newname):

        cmd = "stg rename " + patch + " " + newname
        res, so, se = gquilt_utils.run_cmd(cmd)

        if res != 0:
            return (gquilt_tool.ERROR, so, se)
        else:
            return (gquilt_tool.OK, so, se)

    def do_pop_patch(self, console, force=False):
        cmd = "stg pop"
        res, so, se = _exec_console_cmd(console, cmd)
        if res != 0:
            return (gquilt_tool.ERROR, so, se)
        else:
            return (gquilt_tool.OK, so, se)

    def do_push_patch(self, console, force=False):
        cmd = "stg push"
        res, so, se = _exec_console_cmd(console, cmd)
        # FIXME - stg push likes to run merge tools rather than
        # "requiring refresh" on a push that needs a merge.
        if res != 0:
            return (gquilt_tool.ERROR, so, se)
        else:
            return (gquilt_tool.OK, so, se)

    def do_pop_to_patch(self, console, patch=None):
        cmd = "stg pop "
        if patch is not None:
            if patch == "":
                cmd += "-a"
            else:
                cmd += "-t " + patch
        res, so, se = _exec_console_cmd(console, cmd)
        if res != 0:
            return (gquilt_tool.ERROR, so, se)
        else:
            return (gquilt_tool.OK, so, se)

    def do_push_to_patch(self, console, patch=None):
        cmd = "stg push "
        if patch is not None:
            if patch == "":
                cmd += "-a"
            else:
                cmd += "-t " + patch
        res, so, se = _exec_console_cmd(console, cmd)
        if res != 0:
            return (gquilt_tool.ERROR, so, se)
        else:
            return (gquilt_tool.OK, so, se)

    def do_refresh_patch(self, console, patch=None, force=False):
        if patch is not None:
            if self.top_patch() != patch:
                return( gquilt_tool.ERROR, "", "Only the top patch can be refreshed")

        cmd = "stg refresh"
        res, so, se = _exec_console_cmd(console, cmd)
        if res != 0:
            return (gquilt_tool.ERROR, so, se)
        else:
            return (gquilt_tool.OK, so, se)

    def do_create_new_patch(self, console, name):
        return _exec_console_cmd(console, "stg new -m 'no description' " + name)

    def do_import_patch(self, console, filename):
        return _exec_console_cmd(console, "stg import " + filename)

    # XXX - support this in the UI
    def do_import_email(self, console, filename):
        return _exec_console_cmd(console, "stg import -m " + filename)

    def do_merge_patch(self, console, filename):
        # XXX - see stg fold -t for three-way merge option
        return _exec_console_cmd(console, "stg fold " + filename)

    def do_delete_patch(self, console, patch):
        return _exec_console_cmd(console, "stg delete " + patch)

    def do_add_files_to_patch(self, console, filelist, patch=None):
        if patch is not None:
            if self.top_patch() != patch:
                return( gquilt_tool.ERROR, "", "Only the top patch can have files added to it")
        cmd = "stg add"

        return _exec_console_cmd(console, " ".join([cmd, " ".join(filelist)]))

    def do_remove_files_from_patch(self, console, filelist, patch=None):
        if patch is not None:
            if self.top_patch() != patch:
                return( gquilt_tool.ERROR, "", "Only the top patch can have files removed from it")

        cmd = "stg rm";
        return _exec_console_cmd(console, " ".join([cmd, " ".join(filelist)]))

    def do_exec_tool_cmd(self, console, cmd):
        return _exec_console_cmd(console, " ".join(["stg", cmd]))

--------------090801040700080307040104--
