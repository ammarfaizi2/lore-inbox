Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264635AbSJTTjP>; Sun, 20 Oct 2002 15:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264637AbSJTTjP>; Sun, 20 Oct 2002 15:39:15 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:3589 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264635AbSJTTjN>; Sun, 20 Oct 2002 15:39:13 -0400
Message-ID: <3DB307C3.CFD755C@linux-m68k.org>
Date: Sun, 20 Oct 2002 21:45:07 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: linux kernel conf 1.1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At http://www.xs4all.nl/~zippel/lc/ you can find the latest version of
the new config system.
Smaller changes:
- update to 2.5.44
- new qconf option, which enables some debug output in the help window

The only big change this time is that I added a SWIG interface, which
allows to generate a extension library for your favourite script
language. I did this already for ruby, 'make ruby' builds the library
kconfig.so in the .ruby subdir.
I also included some examples, since they are short and fun, I included
them below.
The first example shows a working (but not very comfortable) miniconf:

-----
require "kconfig"
include Kconfig

conf_parse("arch/i386/Kconfig")
conf_read(nil)

def conf(menu)
        return unless menu.isVisible?
        prompt = menu.prompt
        if prompt.type == P_COMMENT || prompt.type == P_MENU
                print "* #{prompt.text}\n"
        end
        sym = menu.sym
        if sym
                begin
                        print "#{prompt.text} (#{sym.get_string})? "
                        unless sym.isChangable?
                                print "\n"
                                break
                        end
                        val = gets.strip
                end until val.empty? || sym.set_string(val)
        end
        menu.each do |child|
                conf(child)
        end
end

conf(Kconfig.rootmenu)

conf_write(nil)
-----

This is all you need to configure your kernel. :)
The second example prints information about a config option:

-----
require "kconfig"
include Kconfig

conf_parse("arch/i386/Kconfig")
conf_read(nil)

sym = Kconfig::Symbol.find(ARGV[0])
if !sym
        print "Symbol #{ARGV[0]} not found!\n"
        exit
end

sym.calc_value
print "symbol: #{sym.name}\n"
print "  type: #{Kconfig::Symbol.type_name(sym.type)}\n"
print "  value: #{sym.get_string}\n"
print "  choice\n" if sym.isChoice?
print "  choice value\n" if sym.isChoiceValue?
print "  properties:\n" if sym.prop
sym.each do |prop|
        case prop.type
        when P_PROMPT
                print "    prompt: #{prop.text}\n"
        when P_DEFAULT
                prop.def.calc_value
                print "    default: #{prop.def.get_string}\n"
        when P_CHOICE
                print "    choice reference\n"
        else
                print "    unknown property:
#{Property.type_name(prop.type)}\n"
        end
        print "      dep: #{prop.visible.expr}\n" if prop.visible.expr
end
-----

This gives you a basic idea about the internal structures of lkc.

bye, Roman
