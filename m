Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129745AbRAXDGw>; Tue, 23 Jan 2001 22:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130769AbRAXDGn>; Tue, 23 Jan 2001 22:06:43 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:59954 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130107AbRAXDGf>; Tue, 23 Jan 2001 22:06:35 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: hiren_mehta@agilent.com
cc: linux-kernel@vger.kernel.org
Subject: Re: stripping symbols from modules 
In-Reply-To: Your message of "Tue, 23 Jan 2001 16:15:24 PDT."
             <FEEBE78C8360D411ACFD00D0B747797188095D@xsj02.sjs.agilent.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Jan 2001 14:06:29 +1100
Message-ID: <31172.980305589@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001 16:15:24 -0700, 
hiren_mehta@agilent.com wrote:
>That is what I was guessing. But insmod does not need all symbols
>present in the .o. 
>
>I need to do this because when I release the driver to the customer,
>I don't want them to be aware of some of the symbols. I understand
>that this is against the open source policy. But that's how it is
>and it is beyond my control. Is there any way to export only
>selected symbols as required by insmod ? As of now I am not worried
>about ksymoops.

I used this script back in the dim distant days when emergency boot
systems had to fit on floppies.  Not tested since 1998, YMMV.  At the
very least it needs to be updated to keep MODULE_GENERIC_TABLE()
symbols.

#!/bin/sh
#
#	Given a list of objects, strip all static symbols except those
#	required by insmod.
#
#	Copyright Keith Owens <kaos@ocs.com.au>.  GPL.
#	Sat Feb  1 12:52:17 EST 1997
#	
#	Mainly intended for reducing the size of modules to save space
#	on emergency and install disks.  Be aware that removing the
#	static symbols reduces the amount of diagnostic information
#	available for oops.  Not recommended for normal module usage.
#
#	This code requires the modules use MODULE_PARM and EXPORT_.
#	Do not strip modules that have not been converted to use
#	MODULE_PARM or are using the old method of exporting symbols.
#	In particular do not use on modules prior to 2.1.20 (approx).
#
#	The objects are stripped in /tmp, only if the strip works is
#	the original overwritten.  If the command line to strip the
#	symbols becomes too long, the strip is done in multiple passes.
#	Running strip_module twice on the same object is safe (and a
#	waste of time).
#

cat > /tmp/$$.awk <<\EOF
BEGIN	{
	strip = "/usr/bin/objcopy";
	nm = "/usr/bin/nm";
	cp = "/bin/cp";
	mv = "/bin/mv";
	rm = "/bin/rm";
	tmp = "/tmp";
	command_size = 400;	# arbitrary but safe

	getline < "/proc/self/stat";
	pid = $1;
	tmpcopy = tmp "/" pid ".object";
	nmout = tmp "/" pid ".nmout";

	for (i = 1; i < ARGC; ++i)
		strip_module(ARGV[i]);

	do_command(rm " -f " tmpcopy " " nmout);

	exit(0);
}

function strip_module(object,
	keep_symbol, to_strip, symbol, command, changed) {
	do_command(cp " -a " object " " tmpcopy);
	do_command(nm " " tmpcopy " > " nmout);
	# delete array_name sometimes breaks, internal error, play safe
	for (symbol in keep_symbol)
		delete keep_symbol[symbol];
	for (symbol in to_strip)
		delete to_strip[symbol];
	new_module_format = 0;
	while ((getline < nmout) > 0) {
		$0 = substr($0, 10);
		# b static variable, uninitialised
		# d static variable, initialised
		# r static array, initialised
		# t static label/procedures
		if ($1 ~ /[bdrt]/)
			to_strip[$2] = "";
		else if ($1 != "?")
			keep_symbol[$2] = "";
		else if ($0 ~ /\? __ksymtab_/)
			keep_symbol[substr($2, 11)] = "";
		else if ($0 ~ /\? __module_parm_/)
			keep_symbol[substr($2, 15)] = "";
		if ($0 ~ /\? __module/)
			new_module_format = 1;
	}
	close(nmout);
	command = "";
	changed = 0;
	if (new_module_format) {
		for (symbol in to_strip) {
			if (!(symbol in keep_symbol)) {
				changed = 1;
				if (length(command) > command_size) {
					do_command(strip command " " tmpcopy);
					command = "";
				}
				command = command " --strip-symbol=" symbol;
			}
		}
	}
	if (command != "") {
		changed = 1;
		do_command(strip command " " tmpcopy);
	}
	if (changed)
		do_command(mv " " tmpcopy " " object);
}

function do_command(command) {
	if ((ret = system(command)) != 0)
		giveup("command \"" command "\" failed " ret, ret);
}

function giveup(message, ret) {
	print "strip_module: " message > "/dev/stderr";
	exit(ret);
}
EOF

awk -f /tmp/$$.awk "$@"
ret=$?
rm -f /tmp/$$.awk
exit $ret

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
